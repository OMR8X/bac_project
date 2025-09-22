import { z } from "https://deno.land/x/zod/mod.ts";
import { getSupabaseClient } from "./clients.ts";
import type { SupabaseClient } from 'npm:@supabase/supabase-js@2';
import type { QuizRequest, ValidationResult } from "./types.ts";

// ========== ZOD SCHEMAS ==========

const QuestionAnswerSchema = z.object({
  question_id: z.number().positive("Question ID must be positive"),
  option_id: z.number().positive("Option ID must be positive"),
  answer_text: z.string().nullable(),
  answer_position: z.number().nullable()
});

const QuizRequestSchema = z.object({
  is_test_mode: z.boolean().optional(),
  lesson_id: z.number().nullable(),
  duration_seconds: z.number().positive("Duration must be positive"),
  questions_ids: z.array(z.number().positive()),
  questions_answers: z.array(QuestionAnswerSchema).min(1, "At least one answer required")
});

// ========== VALIDATION FUNCTIONS ==========

/**
 * Step 1: Validate request JSON and authenticate user
 * Throws error if validation fails
 */
export async function validateRequestAndUser(req: Request): Promise<ValidationResult> {
  // Initialize Supabase client
  const supabase = getSupabaseClient(req);

  // Parse and validate JSON
  const body = await parseJsonBody(req);

  // Validate request structure
  const requestData = validateRequestSchema(body);

  // Validate user authentication
  const userId = await validateUserAuthentication(supabase);

  return { requestData, userId };
}

/**
 * Parse JSON from request body with error handling
 */
async function parseJsonBody(req: Request): Promise<unknown> {
  try {
    return await req.json();
  } catch (_error) {
    throw new Error("Invalid JSON in request body");
  }
}

/**
 * Validate request data against schema
 */
function validateRequestSchema(data: unknown): QuizRequest {
  try {
    return QuizRequestSchema.parse(data);
  } catch (error) {
    if (error instanceof z.ZodError) {
      throw new Error(`Request validation failed: ${error.errors.map(e => e.message).join(", ")}`);
    }
    throw new Error("Request validation failed");
  }
}

/**
 * Validate user is authenticated and exists
 */
async function validateUserAuthentication(supabase: SupabaseClient): Promise<string> {
  try {
    const { data: { user }, error } = await supabase.auth.getUser();
    if (error) {
      throw new Error("Authentication failed");
    }

    if (!user?.id) {
      throw new Error("User not found or invalid");
    }

    return user.id;
  } catch (error) {
    if (error instanceof Error) {
      throw error;
    }
    throw new Error("Authentication verification failed");
  }
}
