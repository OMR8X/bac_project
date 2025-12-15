-- Function: fn_api_evaluations_get_answers_evaluations_by_ids
-- Description: Gets answer evaluations for given answer IDs
-- Parameters: p_answers_ids integer[]
-- Returns: JSON with answer evaluations data
CREATE OR REPLACE FUNCTION api.fn_api_evaluations_get_answers_evaluations_by_ids(p_answers_ids integer[])
 RETURNS jsonb
 LANGUAGE sql
 SECURITY DEFINER
AS $function$
  SELECT api.api_response(
    json_build_object(
      'answers_evaluations', coalesce(json_agg(evaluations_row), '[]'::json)
    )::jsonb,
    true,
    api.get_message('answer_evaluations_retrieved')
  )
  FROM (
    SELECT
      *
    FROM answer_evaluations
	where question_answer_id = any(p_answers_ids)
  ) AS evaluations_row;
$function$;

