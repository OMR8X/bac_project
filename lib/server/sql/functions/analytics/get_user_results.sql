CREATE OR REPLACE FUNCTION public.get_user_results(p_lesson_id integer DEFAULT NULL::integer, p_limit integer DEFAULT 20, p_offset integer DEFAULT 0)
 RETURNS SETOF results
 LANGUAGE sql
AS $function$
  select *
  from public.results r
  where r.user_id = auth.uid()
    and (p_lesson_id is null or r.lesson_id = p_lesson_id)
  order by r.created_at desc
  limit p_limit
  offset p_offset;
$function$;
