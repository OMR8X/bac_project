CREATE OR REPLACE FUNCTION API.FN_API_RESULTS_GET_USER_RESULT_BY_ID (P_RESULT_ID INT) RETURNS JSONB SECURITY DEFINER AS $$
begin
    return api.api_response(
        (
            with
    current_result as (
      select
        r.*,
        l.title as lesson_title,
        RANK() over () as user_rank,
        json_agg(
          json_build_object(
            'id', qa.id,
            'question_id', qa.question_id,
            'option_id', qa.option_id,
            'answer_text', qa.answer_text,
            'answer_position', qa.answer_position,
            'is_correct', qa.is_correct,
            'result_id', qa.result_id
          )
        ) as question_answers
      from public.results r
      left join public.lessons l on r.lesson_id = l.id
      left join public.question_answers qa on r.id = qa.result_id
      where r.id = p_result_id
        and r.user_id = auth.uid()
      group by r.id, r.user_id, r.lesson_id, r.total_questions, r.correct_answers,
               r.wrong_answers, r.score, r.duration_seconds, r.is_test_mode,
               r.created_at, r.updated_at, l.title
    ),
              previous_results as (
                select
                  r.*,
                  l.title as lesson_title
                from
                  public.results r
                  left join public.lessons l on r.lesson_id = l.id
                where
                  r.user_id = auth.uid()
                and  r.id < P_RESULT_ID
                  and r.id <> p_result_id
                  and r.lesson_id = (select lesson_id from current_result)
                order by r.created_at desc
                limit 5
              )
            select
              json_build_object(
                'result', (select to_jsonb(cr) from current_result cr),
                'previous_results', (select coalesce(json_agg(pr), '[]'::json) from previous_results pr)
              )
        )::jsonb,
        'ok'::text,
        'Result fetched successfully'::text
    );
end;
$$ LANGUAGE PLPGSQL;