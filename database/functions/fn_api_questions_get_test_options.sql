CREATE OR REPLACE FUNCTION api.fn_api_questions_get_test_options(
    p_lessons_ids integer[],
    p_units_ids integer[]
)
RETURNS JSONB
SECURITY DEFINER
LANGUAGE SQL
AS $$
    SELECT api.api_response(
        json_build_object(
            'categories', coalesce(json_agg(category_row ORDER BY category_row.title), '[]'::json)
        )::jsonb,
        'success'::text,
        'Test options retrieved successfully'::text
    )
    FROM (
        SELECT
            c.id,
            c.title,
            c.is_orderable,
            c.is_typeable,
            c.is_mcq,
            c.is_single_answer,
            c.created_at,
            c.updated_at,
            COUNT(q.id) AS questions_count
        FROM question_categories c
        LEFT JOIN questions q
            ON q.category_id = c.id
            AND q.lesson_id = ANY(p_lessons_ids)
        GROUP BY c.id, c.title, c.is_orderable, c.is_typeable, c.is_mcq, c.is_single_answer, c.created_at, c.updated_at
        HAVING COUNT(q.id) > 0
    ) AS category_row;
$$;
