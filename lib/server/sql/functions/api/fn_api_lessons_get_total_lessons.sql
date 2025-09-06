CREATE OR REPLACE FUNCTION api.fn_api_lessons_get_total_lessons(p_unit_id integer DEFAULT NULL::integer, p_search text DEFAULT NULL::text)
 RETURNS json
 LANGUAGE sql
AS $function$
  SELECT json_build_object(
    'lessons', json_agg(lesson_row)
  )
  FROM (
    SELECT
      l.id,
      l.title,
      l.unit_id,
      COUNT(q.id) AS questions_count,
      l.icon,
      l.created_at
    FROM lessons l
    LEFT JOIN questions q ON q.lesson_id = l.id
    WHERE 
      (p_unit_id IS NULL OR l.unit_id = p_unit_id)
      AND (p_search IS NULL OR l.title ILIKE '%' || p_search || '%')
    GROUP BY l.id, l.title, l.unit_id, l.icon , l.created_at
    ORDER BY l.created_at DESC
  ) AS lesson_row;
$function$;
