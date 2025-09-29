-- Function: fn_get_random_motivational_quote
-- Description: Returns a random motivational quote based on used status
-- Parameters: used_status - boolean (true for used, false for unused, null for any)
-- Returns: motivational_quotes record

create or replace function api.fn_get_random_motivational_quote(used_status boolean default null)
returns motivational_quotes
language plpgsql
security definer
as $$
declare
  result motivational_quotes;
begin
  -- If used_status is specified, filter by that status
  -- If used_status is null, get any random quote
  if used_status is not null then
    select * into result
    from motivational_quotes
    where used = used_status
    order by random()
    limit 1;
  else
    select * into result
    from motivational_quotes
    order by random()
    limit 1;
  end if;

  return result;
end;
$$;
