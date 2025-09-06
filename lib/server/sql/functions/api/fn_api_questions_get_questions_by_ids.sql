CREATE OR REPLACE FUNCTION api.fn_api_questions_get_questions_by_ids(
  p_questions_ids int[]
)
RETURNS JSON
LANGUAGE sql
AS $$
  SELECT json_build_object(
    'data', json_agg(q_with_options)
  )
  FROM (
    SELECT 
      q.*,
      COALESCE(
        json_agg(
          json_build_object(
            'id', o.id,
            'text', o.text,
            'is_correct', o.is_correct,
            'image_url', o.image_url,
            'created_at', o.created_at,
            'updated_at', o.updated_at
          )
        ) FILTER (WHERE o.id IS NOT NULL),
        '[]'
      ) AS options
    FROM questions q
    LEFT JOIN options o ON q.id = o.question_id
    WHERE q.id = ANY(p_questions_ids)
    GROUP BY q.id
  ) q_with_options;
$$;
