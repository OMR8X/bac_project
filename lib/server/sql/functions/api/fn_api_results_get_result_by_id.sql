CREATE OR REPLACE FUNCTION api.fn_api_results_get_user_result_by_id(
  p_result_id integer
)
RETURNS JSON
LANGUAGE SQL
AS $$
  WITH current_result AS ( 
    SELECT r.*, l.title as lesson_title
    FROM public.results r
    LEFT JOIN public.lessons l ON r.lesson_id = l.id
    WHERE r.id = p_result_id
      AND r.user_id = auth.uid()
      AND (r.is_visible = true)
  ),
  best_results AS (
    SELECT DISTINCT ON (r.user_id) r.*, l.title as lesson_title
    FROM public.results r
    LEFT JOIN public.lessons l ON r.lesson_id = l.id
    WHERE r.is_visible = true
      AND r.lesson_id IS NOT NULL
      AND r.lesson_id = (SELECT lesson_id FROM current_result)
    ORDER BY r.user_id, r.score DESC, r.duration_seconds ASC
  ),
  top_to_user_results AS (
    SELECT br.*, 
           ROW_NUMBER() OVER (ORDER BY br.score DESC, br.duration_seconds ASC) as result_order
    FROM best_results br
    WHERE br.score >= (SELECT score FROM current_result)
    ORDER BY br.score DESC, br.duration_seconds ASC
  )
  SELECT 
    CASE 
      WHEN (SELECT lesson_id FROM current_result) IS NULL THEN
        -- If no lesson_id, return only the basic result
        json_build_object(
          'data', COALESCE((SELECT to_jsonb(cr) FROM current_result cr), '{}'::jsonb)
        )
      ELSE
        -- If lesson_id exists, return current result and top results down to user
        json_build_object(
          'data', COALESCE((SELECT to_jsonb(cr) FROM current_result cr), '{}'::jsonb),
          'top_results', COALESCE(
            (SELECT json_agg(to_jsonb(tr)) FROM top_to_user_results tr),
            '[]'::json
          )
        )
    END;
$$;
