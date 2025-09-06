CREATE OR REPLACE FUNCTION api.add_user_result(p_user_uuid text, p_questions_ids integer[], p_duration_seconds integer, p_answers jsonb, p_lesson_id integer DEFAULT NULL::integer)
 RETURNS SETOF results
 LANGUAGE plpgsql
AS $function$
declare
  total_questions int := coalesce(array_length(p_questions_ids,1), 0);
  correct_answers int := 0;
  wrong_answers int := 0;
  computed_score numeric(5,2) := 0;
  inserted_row results%rowtype;
begin
  -- Count correct answers for provided question ids
  if p_answers is not null then
    select count(*) into correct_answers
    from jsonb_to_recordset(p_answers) as a(question_id int, selected_option_id int)
    join public.options o on o.id = a.selected_option_id
    where o.is_correct = true
      and a.question_id = any(p_questions_ids);
  else
    correct_answers := 0;
  end if;

  wrong_answers := greatest(total_questions - correct_answers, 0);

  if total_questions > 0 then
    computed_score := round((correct_answers::numeric / total_questions::numeric) * 100.0, 2);
  else
    computed_score := 0;
  end if;

  insert into public.results(
    user_id,
    lesson_id,
    questions_ids,
    total_questions,
    correct_answers,
    wrong_answers,
    score,
    duration_seconds,
    answers,
    created_at,
    updated_at
  )
  values (
    p_user_uuid::uuid,
    p_lesson_id,
    p_questions_ids,
    total_questions,
    correct_answers,
    wrong_answers,
    computed_score,
    p_duration_seconds,
    p_answers,
    now(),
    now()
  )
  returning * into inserted_row;

  return next inserted_row;
  return;
end;
$function$;
