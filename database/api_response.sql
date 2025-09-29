CREATE OR REPLACE FUNCTION api.api_response(
  data JSONB DEFAULT '{}'::jsonb,
  status TEXT DEFAULT 'success',
  message TEXT DEFAULT 'success',
  status_code INTEGER DEFAULT null,
  errors JSONB DEFAULT '{}'::jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN jsonb_build_object(
    'status', status,
    'message', message,
    'statusCode', status_code,
    'errors', errors,
    'data', data
  );
EXCEPTION
  WHEN OTHERS THEN
    RETURN jsonb_build_object(
      'status', 'error',
      'message', SQLERRM,
      'statusCode', null,
      'errors', '{}'::jsonb,
      'data', '{}'::jsonb
    );
END;
$$;