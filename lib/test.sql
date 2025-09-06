-- Creates a function that inserts a result row.
-- Parameters:
--   p_lesson_id        integer | NULL
--   p_questions_ids    integer[] | NULL
--   p_duration_seconds integer (required)
--   p_answers          jsonb (required) -> array of objects { question_id: int, selected_option_id: int|null }
create or replace function api.fn_api_add_user_result (
  p_questions_ids integer[],
  p_duration_seconds integer,
  p_answers jsonb,
  p_lesson_id integer default null
) returns setof results language plpgsql as $$
declare
  total_questions int := coalesce(array_length(p_questions_ids,1), 0);
  correct_answers int := 0;
  wrong_answers int := 0;
  skipped_answers int := 0;
  computed_score numeric(5,2) := 0;
  inserted_row results%rowtype;
begin
   if auth.uid() is null THEN
     return NEXT json_build_object(
       'status', false,
       'code', '401'
     );
   end if;
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

  -- Calculate answered questions (those with non-null selected_option_id)
  declare answered_questions int := 0;
  begin
    if p_answers is not null then
      select count(*) into answered_questions
      from jsonb_to_recordset(p_answers) as a(question_id int, selected_option_id int)
      where a.selected_option_id is not null
        and a.question_id = any(p_questions_ids);
    else
      answered_questions := 0;
    end if;
  end;

  wrong_answers := greatest(answered_questions - correct_answers, 0);
  skipped_answers := greatest(total_questions - answered_questions, 0);

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
  return;
end;
$$;