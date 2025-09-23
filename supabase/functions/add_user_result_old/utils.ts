/// <reference types="https://esm.sh/@supabase/functions-js@2/src/edge-runtime.d.ts" />

// Type definitions
type QuestionOption = {
  id: number;
  content: string | null;
  is_correct: boolean | null;
  sort_order: number | null;
};

type QuestionAnswer = {
  question_id: number;
  option_id: number;
  answer_text: string | null;
  answer_position: number | null;
};

type EnrichedQuestionAnswer = QuestionAnswer & {
  content: string | null;
  is_correct: boolean | null;
  sort_order: number | null;
};



type QuizResult = {
  id: number;
  user_id: string;
  lesson_id: number | null;
  total_questions: number;
  correct_answers: number;
  wrong_answers: number;
  score: number;
  duration_seconds: number;
  is_test_mode: boolean;
  created_at: string;
  updated_at: string;
};

type QuizResultData = {
  userId: string;
  lessonId: number | null;
  totalQuestions: number;
  correctAnswers: number;
  wrongAnswers: number;
  durationSeconds: number;
  isTestMode: boolean;
  processedAnswers: EnrichedQuestionAnswer[];
};

// Constants
const TABLE_NAMES = {
  RESULTS: 'results',
  QUESTION_ANSWERS: 'question_answers',
  QUESTION_OPTIONS: 'question_options'
} as const;

const ERROR_MESSAGES = {
  FETCH_OPTIONS_FAILED: 'Failed to fetch question options',
  SAVE_RESULT_FAILED: 'Failed to save quiz result',
  SAVE_ANSWERS_FAILED: 'Failed to save question answers'
} as const;

// Helper functions
/**
 * Extracts unique option IDs from question answers, filtering out null values
 */
function extractUniqueOptionIds(questionAnswers: QuestionAnswer[]): number[] {
  const optionIds = questionAnswers
    .map(answer => answer.option_id)
    .filter((id): id is number => id !== null);

  return [...new Set(optionIds)];
}

/**
 * Creates a lookup map for quick option retrieval by ID
 */
function createOptionsLookupMap(options: QuestionOption[]): Map<number, QuestionOption> {
  const optionById = new Map<number, QuestionOption>();
  options.forEach((option: QuestionOption) => {
    optionById.set(option.id, option);
  });
  return optionById;
}

/**
 * Calculates quiz score as a percentage
 */
function calculateQuizScore(correctAnswers: number, totalQuestions: number): number {
  return totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;
}

/**
 * Enriches question answers with option data from the database
 * @param questionAnswers - Array of question answers to enrich
 * @param supabase - Supabase client instance
 * @returns Promise resolving to enriched question answers
 */
export async function enrichQuestionsAnswersWithOptions(
  questionAnswers: QuestionAnswer[],
  supabase: any
): Promise<EnrichedQuestionAnswer[]> {
  // Extract unique option IDs from question answers
  const uniqueOptionIds = extractUniqueOptionIds(questionAnswers);

  // If no options to fetch, return answers with null option data
  if (uniqueOptionIds.length === 0) {
    return questionAnswers.map(answer => ({
      ...answer,
      content: null,
      is_correct: null,
      sort_order: null
    }));
  }

  // Fetch option data from database
  const { data: options, error } = await supabase
    .from(TABLE_NAMES.QUESTION_OPTIONS)
    .select('id, content, is_correct, sort_order')
    .in('id', uniqueOptionIds);

  if (error) {
    throw new Error(`${ERROR_MESSAGES.FETCH_OPTIONS_FAILED}: ${error.message}`);
  }

  console.log('DB OPTIONS:', options.map((o: QuestionOption) => `ID:${o.id} sort:${o.sort_order}(${typeof o.sort_order}) correct:${o.is_correct}(${typeof o.is_correct})`).join(' | '));

  // Create lookup map for efficient option retrieval
  const optionById = createOptionsLookupMap(options);

  // Enrich each question answer with corresponding option data
  return questionAnswers.map(answer => {
    const option = answer.option_id ? optionById.get(answer.option_id) : null;
    const enriched = {
      ...answer,
      content: option?.content ?? null,
      is_correct: option?.is_correct ?? null,
      sort_order: option?.sort_order ?? null
    };
    console.log(`ENRICH Q${answer.question_id}: answer_pos=${answer.answer_position} -> sort_order=${enriched.sort_order} | is_correct=${enriched.is_correct}`);
    return enriched;
  });
}

/**
 * Saves quiz result and associated question answers to the database
 * @param resultData - Quiz result data including metadata and answers
 * @param supabase - Supabase client instance
 * @returns Promise resolving to the saved quiz result
 */
export async function saveQuizResult(
  resultData: QuizResultData,
  supabase: any
): Promise<QuizResult> {
  const {
    userId,
    lessonId,
    totalQuestions,
    correctAnswers,
    wrongAnswers,
    durationSeconds,
    isTestMode,
    processedAnswers: processedAnswers
  } = resultData;

  // Calculate final score as percentage
  const finalScore = calculateQuizScore(correctAnswers, totalQuestions);

  // Insert quiz result record
  const { data: result, error: resultError } = await supabase
    .from(TABLE_NAMES.RESULTS)
    .insert({
      user_id: userId,
      lesson_id: lessonId,
      total_questions: totalQuestions,
      correct_answers: correctAnswers,
      wrong_answers: wrongAnswers,
      score: finalScore,
      duration_seconds: durationSeconds,
      is_test_mode: isTestMode
    })
    .select('*')
    .single();

  if (resultError) {
    throw new Error(`${ERROR_MESSAGES.SAVE_RESULT_FAILED}: ${resultError.message}`);
  }

  // Prepare question answers for bulk insertion
  const questionAnswersToInsert = processedAnswers.map((answer: EnrichedQuestionAnswer) => ({
    result_id: result.id,
    question_id: answer.question_id,
    option_id: answer.option_id,
    answer_text: answer.answer_text,
    answer_position: answer.answer_position,
    is_correct: answer.is_correct ?? false
  }));

  // Insert all question answers in a single transaction
  const { error: answersError } = await supabase
    .from(TABLE_NAMES.QUESTION_ANSWERS)
    .insert(questionAnswersToInsert);

  if (answersError) {
    throw new Error(`${ERROR_MESSAGES.SAVE_ANSWERS_FAILED}: ${answersError.message}`);
  }

  return result;
}
