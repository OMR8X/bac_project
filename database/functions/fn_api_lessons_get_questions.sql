CREATE OR REPLACE FUNCTION api.fn_api_lessons_get_questions (
  p_selected_categories integer[],
  p_questions_count integer default null::integer,
  p_lessons_ids integer[] default null::integer[],
  p_show_true_answers boolean default true
) RETURNS json LANGUAGE plpgsql AS $function$
BEGIN
  RETURN (
    WITH eligible_questions AS (  
      SELECT DISTINCT
        q.id,
        q.category_id,
        q.lesson_id,
        -- Create combination rank for each category-lesson pair
        ROW_NUMBER() OVER (
          PARTITION BY q.category_id, q.lesson_id 
          ORDER BY RANDOM()
        ) as combo_rank
      FROM questions q
      WHERE q.category_id = ANY(p_selected_categories)
        AND (p_lessons_ids IS NULL OR q.lesson_id = ANY(p_lessons_ids))
    ),
    round_robin_selection AS (
      SELECT 
        id,
        category_id,
        lesson_id,
        combo_rank,
        -- Create round-robin order across category-lesson combinations
        ROW_NUMBER() OVER (
          ORDER BY 
            combo_rank,                                           -- 1,1,1,1,2,2...
            array_position(p_selected_categories, category_id),   -- Category order
            CASE 
              WHEN p_lessons_ids IS NOT NULL 
              THEN array_position(p_lessons_ids, lesson_id)
              ELSE lesson_id 
            END                                                   -- Lesson order
        ) as selection_order
      FROM eligible_questions
    ),
    selected_ids AS (
      SELECT id, selection_order 
      FROM round_robin_selection 
      WHERE p_questions_count IS NULL OR selection_order <= p_questions_count
    )
    SELECT json_build_object(
      'data', json_build_object(
        'questions', COALESCE(json_agg(
          json_build_object(
            'id', q.id,
            'content', q.content,
            'lesson_id', q.lesson_id,
            'image_url', q.image_url,
            'category_id', q.category_id,
            'created_at', q.created_at,
            'options', COALESCE(
              options.options_array,
              '[]'::json
            )
          ) ORDER BY si.selection_order
        ), '[]'::json)
      )
    )
    FROM selected_ids si
    JOIN questions q ON q.id = si.id
    LEFT JOIN LATERAL (
      SELECT json_agg(
        json_build_object(
          'id', o.id,
          'content', o.content,
          'image_url', o.image_url,
          'sort_order', o.sort_order,
          'is_correct', CASE WHEN p_show_true_answers THEN o.is_correct END
        ) ORDER BY o.id
      ) as options_array
      FROM question_options o 
      WHERE o.question_id = q.id
    ) options ON true
  );
END;
$function$;

