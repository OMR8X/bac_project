-- Centralized messages for database functions
-- Similar to ARB files in Flutter, this file contains all text messages used in API responses

CREATE OR REPLACE FUNCTION api.get_message(message_key TEXT)
RETURNS TEXT
LANGUAGE plpgsql
STABLE
AS $$
DECLARE
  message_text TEXT;
BEGIN
  SELECT message INTO message_text
  FROM public.messages
  WHERE key = message_key;
  -- Return the message if found, otherwise return null
  RETURN message_text;
END;
$$;

