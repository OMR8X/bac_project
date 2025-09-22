CREATE OR REPLACE FUNCTION api.fn_api_lessons_get_total_lessons(
  p_unit_id integer default null,
  p_search text default null
)
RETURNS JSON
SECURITY DEFINER
LANGUAGE SQL
AS $$
  SELECT json_build_object(
    'lessons', json_agg(lesson_row)
  )
  FROM (
    SELECT
      l.id,
      l.title,
      l.unit_id,
      COUNT(q.id) AS questions_count,
      l.icon_url,
      l.created_at
    FROM lessons l
    LEFT JOIN questions q ON q.lesson_id = l.id
    WHERE 
      (p_unit_id IS NULL OR l.unit_id = p_unit_id)
      AND (p_search IS NULL OR l.title ILIKE '%' || p_search || '%')
    GROUP BY l.id, l.title, l.unit_id, l.icon_url , l.created_at
    ORDER BY l.created_at DESC
  ) AS lesson_row;
$$;