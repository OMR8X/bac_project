-- Function: fn_api_send_bulk_notification
-- Description: Sends bulk notifications via edge function
-- Parameters: p_title text, p_body text
-- Returns: JSONB with notification result
CREATE OR REPLACE FUNCTION api.fn_api_send_bulk_notification(p_title text, p_body text)
 RETURNS jsonb
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  v_response JSONB;
  v_status_code INTEGER;
  v_content TEXT;
BEGIN
  -- Make HTTP POST request to the Supabase edge function
  SELECT
    status_code,
    content
  INTO
    v_status_code,
    v_content
  FROM http((
    'POST',
    'https://hvccufhuqizyposxasck.supabase.co/functions/v1/send_bulk_notification',
    ARRAY[
      http_header('Authorization', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh2Y2N1Zmh1cWl6eXBvc3hhc2NrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc2NTE0MDksImV4cCI6MjA3MzIyNzQwOX0.ccQYoUbFmEb-EgIBwKIXkKmVWXM7WTWsGjepICCGJe8'),
      http_header('Content-Type', 'application/json')
    ],
    'application/json',
    json_build_object(
      'title', p_title,
      'body', p_body
    )::TEXT
  ));

  -- Parse the response content as JSON
  BEGIN
    v_response := v_content::JSONB;
  EXCEPTION
    WHEN OTHERS THEN
      v_response := json_build_object('raw_response', v_content);
  END;

  -- Check if the request was successful
  IF v_status_code >= 200 AND v_status_code < 300 THEN
    RETURN api.api_response(
      json_build_object(
        'notification_sent', true,
        'response', v_response,
        'status_code', v_status_code
      )::JSONB,
      'ok'::TEXT,
      'Bulk notification sent successfully'::TEXT
    );
  ELSE
    RETURN api.api_response(
      json_build_object(
        'notification_sent', false,
        'response', v_response,
        'status_code', v_status_code
      )::JSONB,
      'error'::TEXT,
      'Failed to send bulk notification'::TEXT
    );
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    RETURN api.api_response(
      json_build_object(
        'error', SQLERRM,
        'notification_sent', false
      )::JSONB,
      'error'::TEXT,
      'Exception occurred while sending bulk notification'::TEXT
    );
END;
$function$;
