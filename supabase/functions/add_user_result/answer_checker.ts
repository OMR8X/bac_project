// deno-lint-ignore-file
import requestTemplate from "./request_template.json" with { type: "json" };

type EnrichedQuestionAnswer = {
  question_id: number;
  option_id: number;
  answer_text: string | null;
  answer_position: number | null;
  content: string | null;
  is_correct: boolean | null;
  sort_order: number | null;
};

// Check multiple choice question answers (MCQ)
// MCQ answers have: answer_text = null AND answer_position = null
export function checkMcqAnswers(
  enrichedQuestionsAnswers: EnrichedQuestionAnswer[]
): EnrichedQuestionAnswer[] {
  const mcqAnswers = enrichedQuestionsAnswers.filter(
    qa => qa.answer_text === null && qa.answer_position === null
  );

  // Loop through MCQ answers and check correctness
  for (let i = 0; i < mcqAnswers.length; i++) {
    const answer = mcqAnswers[i];
    // FIXED: Check the is_correct property from the option data, not just if option_id exists
    // The is_correct field comes from the database and indicates if this option is the correct answer
    answer.is_correct = answer.is_correct === true;
  }

  return mcqAnswers;
}

// Check text-based answers using AI
// Text answers have: answer_text != null AND answer_position = null
export async function checkTextAnswers(
  enrichedQuestionsAnswers: EnrichedQuestionAnswer[],
  ai: any
): Promise<EnrichedQuestionAnswer[]> {
  const textAnswers = enrichedQuestionsAnswers.filter(
    qa => qa.answer_text !== null && qa.answer_position === null
  );

  // Prepare pairs for AI evaluation
  const pairs = textAnswers.map(answer => ({
    id: answer.option_id?.toString() || "",
    correct_answer: answer.content || "",
    user_answer: answer.answer_text || ""
  }));

  // Skip AI evaluation if no text answers
  if (pairs.length === 0) {
    return textAnswers;
  }

  try {
    // Deep copy template and replace {{pairs}} placeholder
    const requestPayload = JSON.parse(JSON.stringify(requestTemplate));

    // Replace {{pairs}} placeholder with actual pairs data
    requestPayload.contents.forEach((block: any) => {
      block.parts.forEach((part: any) => {
        part.text = part.text.replace("{{pairs}}", JSON.stringify(pairs));
      });
    });

    // Send request to AI
    const response = await ai.models.generateContent(requestPayload);

    // Parse AI response
    const aiResults = response.response?.candidates?.[0]?.content?.parts?.[0]?.json ??
                     JSON.parse(response.text ?? "[]");

    // Update text answers with AI evaluation results
    for (let i = 0; i < textAnswers.length; i++) {
      const answer = textAnswers[i];
      const aiResult = aiResults.find((result: any) => result.id === answer.option_id?.toString());
      if (aiResult) {
        answer.is_correct = aiResult.is_correct || false;
      } else {
        answer.is_correct = false;
      }
    }

  } catch (error) {
    console.error("AI evaluation failed:", error);
    // Fallback: mark all as incorrect if AI fails
    textAnswers.forEach(answer => {
      answer.is_correct = false;
    });
  }

  return textAnswers;
}

// Check order-based answers
// Order answers have: answer_text = null AND answer_position != null
export function checkOrderAnswers(
  enrichedQuestionsAnswers: EnrichedQuestionAnswer[]
): EnrichedQuestionAnswer[] {
  const orderAnswers = enrichedQuestionsAnswers.filter(
    qa => qa.answer_text === null && qa.answer_position !== null
  );

  // Loop through order answers and check correctness
  for (let i = 0; i < orderAnswers.length; i++) {
    const answer = orderAnswers[i];
    // Set is_correct directly based on whether answer_position equals sort_order
    answer.is_correct = answer.answer_position === answer.sort_order;
  }

  return orderAnswers;
}

// Calculate question-level statistics from processed answers
function calculateQuestionStatistics(processedAnswers: EnrichedQuestionAnswer[]): {
  correct_questions: number;
  wrong_questions: number;
  total_questions: number;
} {
  // Group answers by question_id
  const answersByQuestion = new Map<number, EnrichedQuestionAnswer[]>();

  processedAnswers.forEach(answer => {
    if (!answersByQuestion.has(answer.question_id)) {
      answersByQuestion.set(answer.question_id, []);
    }
    answersByQuestion.get(answer.question_id)!.push(answer);
  });

  let correctQuestions = 0;
  let wrongQuestions = 0;

  // Check each question group
  for (const [questionId, answers] of answersByQuestion) {
    // Check if ALL answers for this question are correct
    const allCorrect = answers.every(answer => answer.is_correct === true);

    if (allCorrect) {
      correctQuestions++;
    } else {
      wrongQuestions++;
    }
  }

  return {
    correct_questions: correctQuestions,
    wrong_questions: wrongQuestions,
    total_questions: correctQuestions + wrongQuestions
  };
}

// Function to check user answers against correct options
export async function checkUserAnswers(
  enrichedQuestionsAnswers: EnrichedQuestionAnswer[],
  supabase: any,
  ai: any
): Promise<{
  processed_answers: EnrichedQuestionAnswer[];
  statistics: {
    correct_questions: number;
    wrong_questions: number;
    total_questions: number;
  };
}> {
  // Create empty result list to fill with processed answers
  const processedAnswers: EnrichedQuestionAnswer[] = [];

  // Process MCQ answers and add to result list
  const processedMcqAnswers = checkMcqAnswers(enrichedQuestionsAnswers);
  processedAnswers.push(...processedMcqAnswers);

  // Process text answers and add to result list (async with AI)
  const processedTextAnswers = await checkTextAnswers(enrichedQuestionsAnswers, ai);
  processedAnswers.push(...processedTextAnswers);

  // Process order answers and add to result list
  const processedOrderAnswers = checkOrderAnswers(enrichedQuestionsAnswers);
  processedAnswers.push(...processedOrderAnswers);

  // Calculate question-level statistics
  const statistics = calculateQuestionStatistics(processedAnswers);

  return {
    processed_answers: processedAnswers,
    statistics
  };
}
