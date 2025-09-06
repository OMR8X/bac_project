CREATE OR REPLACE FUNCTION public.add_question_with_options(p_question_text text, p_lesson_id integer, p_options text[], p_is_correct boolean[])
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_question_id INTEGER;
BEGIN
    -- Insert the question
    INSERT INTO questions (text, lesson_id)
    VALUES (p_question_text, p_lesson_id)
    RETURNING id INTO v_question_id;

    -- Insert the options
    INSERT INTO options (text, is_correct, question_id)
    SELECT p_options[i], p_is_correct[i], v_question_id
    FROM generate_subscripts(p_options, 1) AS i;

    -- Return the new question ID
    RETURN v_question_id;
END;
$function$;
