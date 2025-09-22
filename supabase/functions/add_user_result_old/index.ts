import "jsr:@supabase/functions-js@2/edge-runtime.d.ts";
import { AddResultRequestSchema } from "./validation.ts";
import { getGoogleAiClient, getSupabaseClient } from "./clients.ts";
import { enrichQuestionsAnswersWithOptions, saveQuizResult } from "./utils.ts";
import { checkUserAnswers } from "./answer_checker.ts";

// Helper function to create standardized responses
function createResponse(data: unknown, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { "Content-Type": "application/json" },
  });
}

// Helper function to create error responses
function createErrorResponse(message: string, error?: unknown, status = 500) {
  console.error(`Error: ${message}`, error);
  return createResponse({
    success: false,
    message,
    error: error instanceof Error ? error.message : error,
  }, status);
}

// Main function to process quiz result
async function processQuizResult(
  request: unknown,
  supabase: unknown,
  ai: unknown,
  userId: string,
) {
  try {
    // Parse and validate request
    const validatedRequest = AddResultRequestSchema.parse(request);

    if(validatedRequest.questions_answers.length === 0) {
      return createErrorResponse("No questions answers provided", null, 400);
    }

    // Step 1: Enrich questions answers with option data
    const enrichedQuestionsAnswers = await enrichQuestionsAnswersWithOptions(
      validatedRequest.questions_answers,
      supabase,
    );

    // Step 2: Check user answers for correctness
    const answerCheckResult = await checkUserAnswers(
      enrichedQuestionsAnswers,
      supabase,
      ai,
    );

    // Step 3: Save quiz result to database
    const savedResult = await saveQuizResult({
      userId,
      lessonId: validatedRequest.lesson_id,
      totalQuestions: answerCheckResult.statistics.total_questions,
      correctAnswers: answerCheckResult.statistics.correct_questions,
      wrongAnswers: answerCheckResult.statistics.wrong_questions,
      durationSeconds: validatedRequest.duration_seconds,
      isTestMode: validatedRequest.is_test_mode || false,
      processedAnswers: answerCheckResult.processed_answers,
    }, supabase);

    return {
      success: true,
      message: "Quiz result saved successfully",
      result: savedResult,
    };
  } catch (error) {
    throw error; // Re-throw to be handled by caller
  }
}

// Main Deno serve function
Deno.serve(async (req: Request) => {
  try {
    // Initialize clients
    const supabase = getSupabaseClient(req);
    const ai = getGoogleAiClient();

    // Get and validate request body
    const body = await req.json().catch(() => {
      throw new Error("Invalid JSON in request body");
    });

    // Authenticate user
    const { data: { user }, error: authError } = await supabase.auth.getUser();

    if (authError) {
      return createErrorResponse("Authentication failed", authError, 401);
    }

    if (!user?.id) {
      return createErrorResponse("User not found or invalid", null, 401);
    }

    // Process the quiz result
    const result = await processQuizResult(body, supabase, ai, user.id);

    return createResponse(result);
  } catch (error) {
    // Handle validation errors specifically
    if (
      error && typeof error === "object" && "name" in error &&
      error.name === "ZodError"
    ) {
      const zodError = error as { name: string; errors: unknown };
      return createErrorResponse(
        "Request validation failed",
        zodError.errors,
        400,
      );
    }

    // Handle all other errors
    return createErrorResponse("Failed to process quiz result", error);
  }
});
