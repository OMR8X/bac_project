CREATE OR REPLACE FUNCTION api.fn_api_questions_get_test_options(p_units_ids integer[], p_lessons_ids integer[])
 RETURNS json
 LANGUAGE sql
AS $function$
  SELECT json_build_object(
    'categories', json_agg(category_row)
  )
  FROM (
    SELECT
      c.id,
      c.name,
      c.created_at,
      c.updated_at,
      COUNT(q.id) AS questions_count
    FROM categories c
    LEFT JOIN question_categories qc
      ON c.id = qc.category_id
    LEFT JOIN questions q
      ON qc.question_id = q.id
     AND q.lesson_id = ANY(p_lessons_ids)
     AND q.is_visible = true
    GROUP BY c.id, c.name, c.created_at, c.updated_at
    HAVING COUNT(q.id) > 0
    ORDER BY c.name
  ) AS category_row;
$function$;
