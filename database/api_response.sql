CREATE OR REPLACE FUNCTION api.api_response(
  data JSONB DEFAULT '{}'::jsonb,
  success BOOLEAN DEFAULT true,
  message TEXT DEFAULT NULL
)
RETURNS jsonb
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN jsonb_build_object(
    'success', success,
    'message', message,
    'data', data
  );
EXCEPTION
  WHEN OTHERS THEN
    RETURN jsonb_build_object(
      'success', false,
      'message', SQLERRM,
      'data', '{}'::jsonb
    );
END;
$$;