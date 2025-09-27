CREATE OR REPLACE FUNCTION api.api_response(
  data JSONB DEFAULT '{}'::jsonb,
  status TEXT DEFAULT 'ok',
  message TEXT DEFAULT 'success',
  code TEXT DEFAULT null,
  details JSONB DEFAULT '{}'::jsonb
)
RETURNS jsonb
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN jsonb_build_object(
    'status', status,
    'message', message,
    'code', code,
    'details', details,
    'data', data
  );
EXCEPTION
  WHEN OTHERS THEN
    RETURN jsonb_build_object(
      'status', 'error',
      'message', SQLERRM,
      'code', SQLSTATE,
      'details', '{}'::jsonb,
      'data', '{}'::jsonb
    );
END;
$$;