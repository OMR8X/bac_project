import { getGoogleAiClient } from "./clients.ts";
import aiConfig from "./ai-config.json" with { type: "json" };
import type {
  EnrichedAnswer,
  CorrectedAnswer,
  AiEvaluationPair,
  AiEvaluationResult,
  AnswerCorrectionResult
} from "./types.ts";

// ========== ANSWER CORRECTION FUNCTIONS ==========

/**
 * Step 3: Correct all answers using AI for text and simple logic for others
 */
export async function correctAnswers(
  enrichedAnswers: EnrichedAnswer[]
): Promise<AnswerCorrectionResult> {
  // Separate answers by type
  const mcqAnswers = getMcqAnswers(enrichedAnswers);
  const textAnswers = getTextAnswers(enrichedAnswers);
  const orderAnswers = getOrderAnswers(enrichedAnswers);

  // Correct each type
  const correctedMcqAnswers = correctMcqAnswers(mcqAnswers);
  const { correctedAnswers: correctedTextAnswers, aiEvaluations } = await correctTextAnswers(textAnswers);
  console.log("🔍 AI Evaluations:", JSON.stringify(aiEvaluations, null, 2));
  const correctedOrderAnswers = correctOrderAnswers(orderAnswers);

  // Combine all corrected answers
  const allCorrectedAnswers = [...correctedMcqAnswers, ...correctedTextAnswers, ...correctedOrderAnswers];

  return {
    correctedAnswers: allCorrectedAnswers,
    aiEvaluations
  };
}

// ========== ANSWER TYPE DETECTION ==========

function getMcqAnswers(answers: EnrichedAnswer[]): EnrichedAnswer[] {
  return answers.filter(answer =>
    answer.answer_text === null && answer.answer_position === null
  );
}

function getTextAnswers(answers: EnrichedAnswer[]): EnrichedAnswer[] {
  return answers.filter(answer =>
    answer.answer_text !== null && answer.answer_position === null
  );
}

function getOrderAnswers(answers: EnrichedAnswer[]): EnrichedAnswer[] {
  return answers.filter(answer =>
    answer.answer_text === null && answer.answer_position !== null
  );
}

// ========== CORRECTION LOGIC ==========

/**
 * Correct MCQ answers - simple logic based on option correctness
 */
function correctMcqAnswers(answers: EnrichedAnswer[]): CorrectedAnswer[] {
  return answers.map(answer => ({
    ...answer,
    is_correct: answer.option_is_correct === true,
    evaluation_method: 'mcq' as const
  }));
}

/**
 * Correct text answers using AI evaluation
 */
async function correctTextAnswers(answers: EnrichedAnswer[]): Promise<{
  correctedAnswers: CorrectedAnswer[];
  aiEvaluations: AiEvaluationResult[];
}> {
  if (answers.length === 0) {
    return { correctedAnswers: [], aiEvaluations: [] };
  }

  try {
    // Prepare data for AI evaluation
    const evaluationPairs = prepareAiEvaluationPairs(answers);

    // Get AI evaluation results
    const aiResults = await evaluateWithAi(evaluationPairs);

    // Apply AI results to answers
    const correctedAnswers = applyAiResults(answers, aiResults);

    return { correctedAnswers, aiEvaluations: aiResults };
  } catch (error) {
    console.error("AI evaluation failed:", error);
    // Fallback: mark all as incorrect
    const correctedAnswers = answers.map(answer => ({
      ...answer,
      is_correct: false,
      evaluation_method: 'ai' as const
    }));

    return { correctedAnswers, aiEvaluations: [] };
  }
}

/**
 * Correct order answers - simple position comparison
 */
function correctOrderAnswers(answers: EnrichedAnswer[]): CorrectedAnswer[] {
  return answers.map(answer => ({
    ...answer,
    is_correct: answer.answer_position === answer.option_sort_order,
    evaluation_method: 'position' as const
  }));
}

// ========== AI EVALUATION HELPERS ==========

function prepareAiEvaluationPairs(answers: EnrichedAnswer[]): AiEvaluationPair[] {
  return answers.map(answer => ({
    id: answer.option_id?.toString() || "",
    correct_answer: answer.option_content || "",
    user_answer: answer.answer_text || ""
  }));
}

async function evaluateWithAi(pairs: AiEvaluationPair[]): Promise<AiEvaluationResult[]> {
  // Create AI request payload
  const requestPayload = createAiRequestPayload(pairs);

  // Send to AI
  const ai = getGoogleAiClient();
  const response = await ai.models.generateContent(requestPayload);

  // Parse response
  return parseAiResponse(response);
}

function createAiRequestPayload(pairs: AiEvaluationPair[]) {
  const requestPayload = JSON.parse(JSON.stringify(aiConfig));

  // Replace {{pairs}} placeholder with actual pairs data
  requestPayload.contents.forEach((block: unknown) => {
    if (block && typeof block === 'object' && 'parts' in block) {
      const blockObj = block as { parts: unknown[] };
      blockObj.parts.forEach((part: unknown) => {
        if (part && typeof part === 'object' && 'text' in part) {
          const partObj = part as { text: string };
          partObj.text = partObj.text.replace("{{pairs}}", JSON.stringify(pairs));
        }
      });
    }
  });

  return requestPayload;
}

function parseAiResponse(response: unknown): AiEvaluationResult[] {
  console.log("🔍 Raw AI Response:", JSON.stringify(response, null, 2));

  let aiResults: unknown[] = [];

  if (response && typeof response === 'object') {
    const respObj = response as Record<string, unknown>;
    if ('response' in respObj && respObj.response && typeof respObj.response === 'object') {
      const resp = respObj.response as Record<string, unknown>;
      if ('candidates' in resp && Array.isArray(resp.candidates) && resp.candidates[0]) {
        const candidate = resp.candidates[0] as Record<string, unknown>;
        if ('content' in candidate && candidate.content && typeof candidate.content === 'object') {
          const content = candidate.content as Record<string, unknown>;
          if ('parts' in content && Array.isArray(content.parts) && content.parts[0]) {
            const part = content.parts[0] as Record<string, unknown>;
            if ('json' in part && part.json) {
              aiResults = part.json as unknown[];
              console.log("📝 Parsed AI JSON Results:", JSON.stringify(aiResults, null, 2));
            }
          }
        }
      }
    } else if ('text' in respObj && typeof respObj.text === 'string') {
      try {
        aiResults = JSON.parse(respObj.text);
      } catch {
        aiResults = [];
      }
    }
  }

  // Add model name to each result
  const resultsWithModel = Array.isArray(aiResults) ? aiResults.map(result => ({
    ...(result as Record<string, unknown>),
    model_name: "gemini-2.5-flash"
  } as AiEvaluationResult)) : [];

  console.log("✅ Final AI Evaluation Results:", JSON.stringify(resultsWithModel, null, 2));

  return resultsWithModel;
}

function applyAiResults(
  answers: EnrichedAnswer[],
  aiResults: AiEvaluationResult[]
): CorrectedAnswer[] {
  return answers.map(answer => {
    const aiResult = aiResults.find(result =>
      result.id === answer.option_id?.toString()
    );

    return {
      ...answer,
      is_correct: aiResult?.is_correct || false,
      evaluation_method: 'ai' as const
    };
  });
}
