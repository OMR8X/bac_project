import "jsr:@supabase/functions-js@2/edge-runtime.d.ts";
import { validateRequestAndUser } from "./validation.ts";
import { enrichAnswersWithOptions } from "./data-enrichment.ts";
import { correctAnswers } from "./answer-correction.ts";
import { saveQuizResult } from "./database-operations.ts";
import type { SuccessResponse, ErrorResponse, AnswerCorrectionResult } from "./types.ts";

// ========== RESPONSE HELPERS ==========

function createResponse(data: SuccessResponse | ErrorResponse, _status = 200): Response {
  return new Response(JSON.stringify(data), {
    status: _status,
    headers: { "Content-Type": "application/json" },
  });
}

function createErrorResponse(message: string, error?: unknown, _status = 500): ErrorResponse {
  console.error(`Error: ${message}`, error);
  return {
    success: false,
    message,
    error: error instanceof Error ? error.message : String(error)
  };
}

// ========== MAIN FUNCTION ==========

/**
 * Add User Result Function - Version 2
 * Clean 4-step implementation for better readability and maintainability
 */
Deno.serve(async (req: Request) => {
  try {
    // Step 1: Validate request and user authentication
    const { requestData, userId } = await validateRequestAndUser(req);

    // Step 2: Fetch options data and enrich question answers
    const enrichedAnswers = await enrichAnswersWithOptions(requestData.questions_answers);

    // Step 3: Correct answers (AI for text, simple logic for others)
    const correctionResult: AnswerCorrectionResult = await correctAnswers(enrichedAnswers);

    // Step 4: Save quiz result and answers to database
    const result = await saveQuizResult(requestData, userId, correctionResult.correctedAnswers, correctionResult.aiEvaluations);

    // Return success response
    const successResponse: SuccessResponse = {
      success: true,
      message: "Quiz result saved successfully",
      result
    };

    return createResponse(successResponse);
  } catch (error) {
    // Handle validation errors specifically
    if (error instanceof Error && error.message.includes("Request validation failed")) {
      return createResponse(createErrorResponse(error.message, null, 400), 400);
    }

    // Handle authentication errors
    if (error instanceof Error && (
      error.message.includes("Authentication failed") ||
      error.message.includes("User not found")
    )) {
      return createResponse(createErrorResponse(error.message, null, 401), 401);
    }

    // Handle all other errors
    return createResponse(createErrorResponse("Failed to process quiz result", error), 500);
  }
});
