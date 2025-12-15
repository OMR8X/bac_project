-- Function: fn_get_random_motivational_quote
-- Description: Returns a random motivational quote based on used status
-- Parameters: used_status - boolean (true for used, false for unused, null for any)
-- Returns: JSONB response with motivational quote data

create or replace function api.fn_get_random_motivational_quote(used_status boolean default null)
returns jsonb
language plpgsql
security definer
as $$
declare
  result_record motivational_quotes;
begin
  -- If used_status is specified, filter by that status
  -- If used_status is null, get any random quote
  if used_status is not null then
    select * into result_record
    from motivational_quotes
    where used = used_status
    order by random()
    limit 1;
  else
    select * into result_record
    from motivational_quotes
    order by random()
    limit 1;
  end if;

  -- Return the standardized response
  return api.api_response(
    jsonb_build_object(
      'quote',
      coalesce(row_to_json(result_record), '{}'::json)
    ),
    true,
    api.get_message('motivational_quote_retrieved')
  );
end;
$$;
