-- Function: fn_api_evaluations_get_answers_evaluations_by_ids
-- Description: Gets answer evaluations for given answer IDs
-- Parameters: p_answers_ids integer[]
-- Returns: JSON with answer evaluations data
CREATE OR REPLACE FUNCTION api.fn_api_evaluations_get_answers_evaluations_by_ids(p_answers_ids integer[])
 RETURNS json
 LANGUAGE sql
 SECURITY DEFINER
AS $function$
  SELECT json_build_object(
    'answers_evaluations', json_agg(evaluations_row )
  )
  FROM (
    SELECT
      *
    FROM answer_evaluations
	where question_answer_id = any(p_answers_ids)
  ) AS evaluations_row;
$function$;

