CREATE OR REPLACE FUNCTION api.fn_api_add_user_result(p_questions_ids integer[], p_duration_seconds integer, p_answers jsonb, p_lesson_id integer DEFAULT NULL::integer)
 RETURNS SETOF results
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
declare
  total_questions int := coalesce(array_length(p_questions_ids,1), 0);
  correct_answers int := 0;
  wrong_answers int := 0;
  skipped_answers int := 0;
  computed_score numeric(5,2) := 0;
  inserted_row results%rowtype;
begin
  if auth.uid() is null then
    raise exception '401: unauthorized';
  end if;

  if p_answers is not null then
    -- Count correct answers
    select count(*) into correct_answers
    from jsonb_to_recordset(p_answers) as a(question_id int, selected_option_id int)
    join public.options o on o.id = a.selected_option_id
    where o.is_correct = true
      and a.question_id = any(p_questions_ids);

    -- Count skipped answers
    select count(*) into skipped_answers
    from jsonb_to_recordset(p_answers) as a(question_id int, selected_option_id int)
    where a.selected_option_id is null
      and a.question_id = any(p_questions_ids);

    -- Wrong answers = total - correct - skipped
    wrong_answers := greatest(total_questions - correct_answers - skipped_answers, 0);
  else
    correct_answers := 0;
    wrong_answers := 0;
    skipped_answers := total_questions;
  end if;

  -- Score only based on answered questions (correct / total)
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
    skipped_answers,
    score,
    duration_seconds,
    answers,
    created_at,
    updated_at
  )
  values (
    auth.uid(),
    p_lesson_id,
    p_questions_ids,
    total_questions,
    correct_answers,
    wrong_answers,
    skipped_answers,
    computed_score,
    p_duration_seconds,
    p_answers,
    now(),
    now()
  )
  returning * into inserted_row;

  return next inserted_row;
end;
$function$;
