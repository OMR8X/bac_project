-- Function: fn_api_device_tokens_register_device_token
-- Description: Registers a device token for a user
-- Parameters:
-- Returns:
create or replace function api.fn_api_device_tokens_register_device_token(
  p_device_brand text,
  p_device_model text,
  p_device_token text
)
returns jsonb
language plpgsql
security definer
as $$
declare
  result_record record;
begin
  -- Perform the insert/upsert
  insert into user_device_tokens (user_id, device_brand, device_model, device_token, updated_at)
  values (auth.uid(), p_device_brand, p_device_model, p_device_token, now())
  on conflict (user_id, device_token)
  do update set
    device_brand = excluded.device_brand,
    device_model = excluded.device_model,
    updated_at  = now();

  -- Get the device token record
  select * into result_record
  from user_device_tokens
  where user_id = auth.uid() and device_token = p_device_token;

  -- Return the standardized response
  return api.api_response(
    coalesce(row_to_json(result_record), '{}'::json)::jsonb,
    'ok'::text,
    'Device token registered successfully'::text
  );
end;
$$;


