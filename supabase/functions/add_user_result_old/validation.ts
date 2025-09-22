import { z } from "https://deno.land/x/zod/mod.ts";

// Zod schemas for request validation
export const QuestionAnswerSchema = z.object({
  question_id: z.number().positive("Question ID must be positive"),
  option_id: z.number().positive("Option ID must be positive"),
  answer_text: z.string().nullable(),
  answer_position: z.number().nullable()
});

export const AddResultRequestSchema = z.object({
  is_test_mode: z.boolean().optional(),
  lesson_id: z.number().nullable(),
  duration_seconds: z.number(),
  questions_ids: z.array(z.number()),
  questions_answers: z.array(QuestionAnswerSchema)
});
