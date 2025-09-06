CREATE OR REPLACE FUNCTION api.fn_api_results_get_user_result_by_id(
  p_result_id integer
)
RETURNS JSON
LANGUAGE SQL
AS $$
  SELECT json_build_object(
    'data',
    COALESCE(
      (
        SELECT to_jsonb(r) || jsonb_build_object('lesson_title', l.title) AS result_data
        FROM public.results r
        LEFT JOIN public.lessons l ON r.lesson_id = l.id
        WHERE r.id = p_result_id
          AND r.user_id = auth.uid()
          AND (r.is_visible = true)
      ),
      '{}'::jsonb
    )
  );
$$;
