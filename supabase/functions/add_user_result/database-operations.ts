import { getSupabaseClient } from "./clients.ts";
import type {
  QuizRequest,
  CorrectedAnswer,
  QuizResult,
  QuizStatistics,
  QuestionAnswerRecord,
  AiEvaluationResult,
  AnswerEvaluationRecord
} from "./types.ts";

// ========== CONSTANTS ==========

const TABLE_NAMES = {
  RESULTS: 'results',
  QUESTION_ANSWERS: 'question_answers',
  ANSWER_EVALUATIONS: 'answer_evaluations'
} as const;

const ERROR_MESSAGES = {
  SAVE_RESULT_FAILED: 'Failed to save quiz result',
  SAVE_ANSWERS_FAILED: 'Failed to save question answers',
  SAVE_EVALUATIONS_FAILED: 'Failed to save answer evaluations'
} as const;

// ========== DATABASE OPERATIONS ==========

/**
 * Step 4: Save quiz result and all answers to database
 */
export async function saveQuizResult(
  requestData: QuizRequest,
  userId: string,
  correctedAnswers: CorrectedAnswer[],
  aiEvaluations: AiEvaluationResult[]
): Promise<QuizResult> {
  // Calculate statistics from corrected answers
  const statistics = calculateStatistics(correctedAnswers);

  // Save quiz result record
  const result = await saveResultRecord(requestData, userId, statistics);

  // Save all answer records and get their IDs
  const savedAnswerRecords = await saveAnswerRecords(result.id, correctedAnswers);

  // Save AI evaluations if any exist
  if (aiEvaluations.length > 0) {
    await saveAiEvaluations(savedAnswerRecords, aiEvaluations);
  }

  return result;
}

/**
 * Calculate quiz statistics from corrected answers
 */
function calculateStatistics(answers: CorrectedAnswer[]): QuizStatistics {
  // Group answers by question_id
  const answersByQuestion = new Map<number, CorrectedAnswer[]>();

  answers.forEach(answer => {
    if (!answersByQuestion.has(answer.question_id)) {
      answersByQuestion.set(answer.question_id, []);
    }
    answersByQuestion.get(answer.question_id)!.push(answer);
  });

  let correctQuestions = 0;
  let wrongQuestions = 0;

  // Check each question group - ALL answers must be correct
  for (const [_questionId, questionAnswers] of answersByQuestion) {
    const allCorrect = questionAnswers.every(answer => answer.is_correct === true);
    if (allCorrect) {
      correctQuestions++;
    } else {
      wrongQuestions++;
    }
  }

  return {
    total_questions: correctQuestions + wrongQuestions,
    correct_questions: correctQuestions,
    wrong_questions: wrongQuestions
  };
}

/**
 * Save the main quiz result record
 */
async function saveResultRecord(
  requestData: QuizRequest,
  userId: string,
  statistics: QuizStatistics
): Promise<QuizResult> {
  const supabase = getSupabaseClient();

  // Calculate final score as percentage
  const finalScore = statistics.total_questions > 0
    ? (statistics.correct_questions / statistics.total_questions) * 100
    : 0;

  // Insert result record
  const { data: result, error } = await supabase
    .from(TABLE_NAMES.RESULTS)
    .insert({
      user_id: userId,
      lesson_id: requestData.lesson_id,
      total_questions: statistics.total_questions,
      correct_answers: statistics.correct_questions,
      wrong_answers: statistics.wrong_questions,
      score: finalScore,
      duration_seconds: requestData.duration_seconds,
      is_test_mode: requestData.is_test_mode || false
    })
    .select('*')
    .single();

  if (error) {
    throw new Error(`${ERROR_MESSAGES.SAVE_RESULT_FAILED}: ${error.message}`);
  }

  return result;
}

/**
 * Save all question answer records and return them with IDs
 */
async function saveAnswerRecords(
  resultId: number,
  correctedAnswers: CorrectedAnswer[]
): Promise<QuestionAnswerRecord[]> {
  const supabase = getSupabaseClient();

  // Prepare answer records for bulk insertion
  const answerRecords = correctedAnswers.map(answer => createAnswerRecord(resultId, answer));

  // Insert all answers and get them back with IDs
  const { data: savedAnswers, error } = await supabase
    .from(TABLE_NAMES.QUESTION_ANSWERS)
    .insert(answerRecords)
    .select('*');

  if (error) {
    throw new Error(`${ERROR_MESSAGES.SAVE_ANSWERS_FAILED}: ${error.message}`);
  }

  return savedAnswers || [];
}

/**
 * Create a question answer record from corrected answer
 */
function createAnswerRecord(resultId: number, answer: CorrectedAnswer): QuestionAnswerRecord {
  return {
    result_id: resultId,
    question_id: answer.question_id,
    option_id: answer.option_id,
    answer_text: answer.answer_text,
    answer_position: answer.answer_position,
    is_correct: answer.is_correct
  };
}

/**
 * Save AI evaluation records
 */
async function saveAiEvaluations(
  savedAnswerRecords: QuestionAnswerRecord[],
  aiEvaluations: AiEvaluationResult[]
): Promise<void> {
  const supabase = getSupabaseClient();

  // Create evaluation records by matching AI results with saved answer records
  const evaluationRecords: AnswerEvaluationRecord[] = [];

  for (const evaluation of aiEvaluations) {
    // Find the corresponding answer record by option_id
    const matchingAnswer = savedAnswerRecords.find(answer =>
      answer.option_id?.toString() === evaluation.id
    );

    if (matchingAnswer && matchingAnswer.id) {
      evaluationRecords.push({
        question_answer_id: matchingAnswer.id,
        is_correct: evaluation.is_correct,
        confidence: evaluation.confidence,
        notes: evaluation.notes,
        model_name: evaluation.model_name
      });
    }
  }

  if (evaluationRecords.length === 0) {
    return; // No evaluations to save
  }

  // Insert all evaluation records
  const { error } = await supabase
    .from(TABLE_NAMES.ANSWER_EVALUATIONS)
    .insert(evaluationRecords);

  if (error) {
    throw new Error(`${ERROR_MESSAGES.SAVE_EVALUATIONS_FAILED}: ${error.message}`);
  }
}
