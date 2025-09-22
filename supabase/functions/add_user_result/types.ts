// All type definitions for the add_user_result function
// Organized by data flow: Request -> Enriched -> Corrected -> Result

// ========== REQUEST TYPES ==========

export interface QuestionAnswer {
  question_id: number;
  option_id: number;
  answer_text: string | null;
  answer_position: number | null;
}
export interface AnswerEvaluations {
  question_answer_id: number;
  is_correct: boolean;
  confidence: number | null;
  notes: string | null;
  model_name: string | null;
}


export interface QuizRequest {
  is_test_mode?: boolean;
  lesson_id: number | null;
  duration_seconds: number;
  questions_ids: number[];
  questions_answers: QuestionAnswer[];
}

// ========== ENRICHED TYPES (After fetching options) ==========

export interface QuestionOption {
  id: number;
  content: string | null;
  is_correct: boolean | null;
  sort_order: number | null;
}

export interface EnrichedAnswer extends QuestionAnswer {
  // Additional data from database
  option_content: string | null;
  option_is_correct: boolean | null;
  option_sort_order: number | null;
}

// ========== CORRECTED TYPES (After answer evaluation) ==========

export interface CorrectedAnswer extends EnrichedAnswer {
  // Evaluation result
  is_correct: boolean;
  evaluation_method: 'mcq' | 'ai' | 'position';
}

// ========== RESULT TYPES ==========

export interface QuizStatistics {
  total_questions: number;
  correct_questions: number;
  wrong_questions: number;
}

export interface QuizResult {
  id: number;
  user_id: string;
  lesson_id: number | null;
  total_questions: number;
  correct_answers: number;
  wrong_answers: number;
  score: number; // Percentage (0-100)
  duration_seconds: number;
  is_test_mode: boolean;
  created_at: string;
  updated_at: string;
}

// ========== DATABASE RECORD TYPES ==========

export interface QuestionAnswerRecord {
  id?: number; // Will be set after insert
  result_id: number;
  question_id: number;
  option_id: number | null;
  answer_text: string | null;
  answer_position: number | null;
  is_correct: boolean;
}

export interface AnswerEvaluationRecord {
  question_answer_id: number;
  is_correct: boolean;
  confidence: number | null;
  notes: string | null;
  model_name: string | null;
}

// ========== API RESPONSE TYPES ==========

export interface SuccessResponse {
  success: true;
  message: string;
  result: QuizResult;
}

export interface ErrorResponse {
  success: false;
  message: string;
  error: string;
}

// ========== INTERNAL PROCESSING TYPES ==========

export interface ValidationResult {
  requestData: QuizRequest;
  userId: string;
}

export interface AnswerCorrectionResult {
  correctedAnswers: CorrectedAnswer[];
  aiEvaluations: AiEvaluationResult[];
}

// ========== AI TYPES ==========

export interface AiEvaluationPair {
  id: string;
  correct_answer: string;
  user_answer: string;
}

export interface AiEvaluationResult {
  id: string;
  correct_answer: string;
  user_answer: string;
  is_correct: boolean;
  confidence: number;
  notes: string;
  model_name: string | null;
}
