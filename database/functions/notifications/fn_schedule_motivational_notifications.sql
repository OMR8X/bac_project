-- Function: fn_schedule_motivational_notifications
-- Description: Calls the send_motivational_quote Edge Function to send motivational notifications
-- Parameters: None
-- Returns: jsonb response with the result

create or replace function api.fn_schedule_motivational_notifications()
returns jsonb
language plpgsql
security definer
as $$
declare
  supabase_url text;
  supabase_service_key text;
  http_response record;
  request_headers http_header[];
begin
  -- Get Supabase configuration from vault
  supabase_url := (select decrypted_secret from vault.decrypted_secrets where name = 'supabase_url') || '/functions/v1/send_motivational_quote';
  supabase_service_key := (select decrypted_secret from vault.decrypted_secrets where name = 'supabase_anon_key');

  -- Prepare headers for the HTTP request (same as Flutter app)
  request_headers := array[
    http_header('apikey', supabase_service_key),
    http_header('Authorization', 'Bearer ' || supabase_service_key),
    http_header('Content-Type', 'application/json')
  ];

  -- Make HTTP POST request to the send_motivational_quote Edge Function
  select * into http_response
  from http((
    'POST',
    supabase_url,
    request_headers,
    'application/json',
    '{}'::text  -- Empty JSON body since the Edge Function doesn't require parameters
  ));

  -- Check if the request was successful
  if http_response.status >= 200 and http_response.status < 300 then
    -- Return success response
    return api.api_response(
      jsonb_build_object(
        'http_status', http_response.status,
        'response', http_response.content::jsonb,
        'scheduled_at', now()
      ),
      true,
      api.get_message('motivational_notification_sent')
    );
  else
    -- Return error response
    return api.api_response(
      jsonb_build_object(
        'http_status', http_response.status,
        'error_response', http_response.content::jsonb,
        'scheduled_at', now()
      ),
      false,
      api.get_message('failed_to_send_motivational_notification')
    );
  end if;

exception
  when others then
    -- Handle any exceptions
    return api.api_response(
      jsonb_build_object(
        'error', SQLERRM,
        'scheduled_at', now()
      ),
      false,
      api.get_message('exception_sending_motivational_notification')
    );
end;
$$;
