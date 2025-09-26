CREATE OR REPLACE FUNCTION api.fn_api_get_user_results(
  p_lesson_id integer DEFAULT NULL,
  p_limit integer DEFAULT 20,
  p_offset integer DEFAULT 0
)
RETURNS JSON
SECURITY DEFINER
LANGUAGE plpgsql
AS $$
DECLARE
  result_data json;
  total_count integer;
  current_page integer;
  last_page integer;
BEGIN
  -- Get total count for pagination
  SELECT COUNT(*) INTO total_count
  FROM public.results r
  WHERE r.user_id = auth.uid()
    AND (p_lesson_id IS NULL OR r.lesson_id = p_lesson_id);

  -- Calculate pagination metadata
  current_page := (p_offset / p_limit) + 1;
  last_page := CASE WHEN total_count > 0 THEN CEIL(total_count::float / p_limit) ELSE 1 END;

  -- Get paginated results
  result_data := COALESCE(
    (
      SELECT json_agg(result_row)
      FROM (
        SELECT to_jsonb(r) || jsonb_build_object('lesson_title', l.title) AS result_row
        FROM public.results r
        LEFT JOIN public.lessons l ON r.lesson_id = l.id
        WHERE r.user_id = auth.uid()
          AND (p_lesson_id IS NULL OR r.lesson_id = p_lesson_id)
        ORDER BY r.created_at DESC
        LIMIT p_limit
        OFFSET p_offset
      ) AS t
    ),
    '[]'::json
  );

  RETURN api.api_response(
    data := json_build_object('results', result_data),
    current_page := current_page,
    last_page := last_page,
    message := 'User results retrieved successfully'
  );
END;
$$;