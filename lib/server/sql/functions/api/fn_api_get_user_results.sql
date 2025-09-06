CREATE OR REPLACE FUNCTION api.fn_api_get_user_results(p_lesson_id integer DEFAULT NULL::integer, p_limit integer DEFAULT 20, p_offset integer DEFAULT 0)
 RETURNS json
 LANGUAGE sql
AS $function$
  SELECT json_build_object(
    'results',
    COALESCE(
      (
        SELECT (json_agg(result_row))::json
        FROM (
          SELECT to_jsonb(r) || jsonb_build_object('lesson_title', l.title) AS result_row
          FROM public.results r
          LEFT JOIN public.lessons l ON r.lesson_id = l.id
          WHERE r.user_id = auth.uid()
            AND (p_lesson_id IS NULL OR r.lesson_id = p_lesson_id)
            AND (r.is_visible = true)
          ORDER BY r.created_at DESC
          LIMIT p_limit
          OFFSET p_offset
        ) AS t
      ),
      '[]'::json
    )
  );
$function$;
