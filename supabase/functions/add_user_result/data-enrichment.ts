import { getSupabaseClient } from "./clients.ts";
import type { SupabaseClient } from 'npm:@supabase/supabase-js@2';
import type { QuestionAnswer, EnrichedAnswer, QuestionOption } from "./types.ts";

// ========== CONSTANTS ==========

const TABLE_NAMES = {
  QUESTION_OPTIONS: 'question_options'
} as const;

const ERROR_MESSAGES = {
  FETCH_OPTIONS_FAILED: 'Failed to fetch question options'
} as const;

// ========== DATA ENRICHMENT FUNCTIONS ==========

/**
 * Step 2: Fetch options data and enrich question answers
 * Takes answers and adds option details from database
 */
export async function enrichAnswersWithOptions(
  answers: QuestionAnswer[]
): Promise<EnrichedAnswer[]> {
  // Extract unique option IDs from answers
  const uniqueOptionIds = extractUniqueOptionIds(answers);

  // If no options to fetch, return answers with null option data
  if (uniqueOptionIds.length === 0) {
    return answers.map(answer => createEnrichedAnswer(answer, null));
  }

  // Fetch option data from database
  const supabase = getSupabaseClient();
  const options = await fetchOptionsData(supabase, uniqueOptionIds);

  // Create lookup map for efficient option retrieval
  const optionById = createOptionsLookupMap(options);

  // Enrich each answer with corresponding option data
  return answers.map(answer => {
    const option = answer.option_id ? optionById.get(answer.option_id) ?? null : null;
    return createEnrichedAnswer(answer, option);
  });
}

/**
 * Extract unique option IDs from answers, filtering out null values
 */
function extractUniqueOptionIds(answers: QuestionAnswer[]): number[] {
  const optionIds = answers
    .map(answer => answer.option_id)
    .filter((id): id is number => id !== null);

  return [...new Set(optionIds)];
}

/**
 * Fetch option data from database
 */
async function fetchOptionsData(supabase: SupabaseClient, optionIds: number[]): Promise<QuestionOption[]> {
  const { data: options, error } = await supabase
    .from(TABLE_NAMES.QUESTION_OPTIONS)
    .select('id, content, is_correct, sort_order')
    .in('id', optionIds);

  if (error) {
    throw new Error(`${ERROR_MESSAGES.FETCH_OPTIONS_FAILED}: ${error.message}`);
  }

  return options || [];
}

/**
 * Create lookup map for efficient option retrieval by ID
 */
function createOptionsLookupMap(options: QuestionOption[]): Map<number, QuestionOption> {
  const optionById = new Map<number, QuestionOption>();
  options.forEach(option => {
    optionById.set(option.id, option);
  });
  return optionById;
}

/**
 * Create enriched answer by combining answer data with option data
 */
function createEnrichedAnswer(
  answer: QuestionAnswer,
  option: QuestionOption | null
): EnrichedAnswer {
  return {
    ...answer,
    option_content: option?.content ?? null,
    option_is_correct: option?.is_correct ?? null,
    option_sort_order: option?.sort_order ?? null
  };
}
