-- Function: fn_api_results_get_result_questions_details
-- Description: Gets detailed questions data for a specific result including options, answers, and evaluations
-- Parameters: p_result_id bigint
-- Returns: JSON with detailed questions data
CREATE OR REPLACE FUNCTION api.fn_api_results_get_result_questions_details(p_result_id bigint)
 RETURNS json
 LANGUAGE sql
 SECURITY DEFINER
AS $function$
WITH questions_answers_list AS (
    SELECT *
    FROM question_answers
    WHERE result_id = p_result_id
)
SELECT json_build_object(
    'questions', json_agg(question_data)
) AS result_questions
FROM (
    SELECT
        q.id AS id,
        q.content AS content,
        q.image_url AS image_url,
        q.lesson_id AS lesson_id,
        q.category_id AS category_id,
        -- Aggregate options per question
        json_agg(DISTINCT jsonb_build_object(
            'id', o.id,
            'content', o.content,
            'is_correct', o.is_correct,
            'sort_order', o.sort_order,
            'image_url', o.image_url
        )) FILTER (WHERE o.id IS NOT NULL) AS options,
        -- Aggregate student answers per question
        json_agg(DISTINCT jsonb_build_object(
            'id', a.id,
            'option_id', a.option_id,
            'answer_text', a.answer_text,
            'answer_position', a.answer_position,
            'is_correct', a.is_correct
        )) FILTER (WHERE a.id IS NOT NULL) AS question_answers,
        -- Aggregate evaluations per question
        json_agg(DISTINCT jsonb_build_object(
            'id', ae.id,
            'is_correct', ae.is_correct,
            'confidence', ae.confidence,
            'question_answer_id', ae.question_answer_id,
            'notes', ae.notes,
            'model_name', ae.model_name
        )) FILTER (WHERE ae.id IS NOT NULL) AS answer_evaluations
    FROM questions q
    LEFT JOIN question_options o ON o.question_id = q.id
    LEFT JOIN questions_answers_list a ON a.question_id = q.id
    LEFT JOIN answer_evaluations ae ON ae.question_answer_id = a.id
    WHERE q.id IN (SELECT question_id FROM questions_answers_list)
    GROUP BY q.id
    ORDER BY q.id
) AS question_data;
$function$;

