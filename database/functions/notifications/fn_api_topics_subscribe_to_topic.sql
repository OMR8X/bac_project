-- Function: fn_api_topics_subscribe_to_topic
-- Description: Subscribes a user to a notification topic
-- Parameters:
-- Returns:
create or replace function api.fn_api_topics_subscribe_to_topic(
  p_topic_id bigint
)
returns jsonb
language plpgsql
security definer
as $$
declare
  result_record record;
begin
  -- Perform the insert/upsert
  insert into user_topic_subscriptions (user_id, topic_id)
  values (auth.uid(), p_topic_id)
  on conflict (user_id, topic_id) do nothing;

  -- Get the subscription record
  select * into result_record
  from user_topic_subscriptions
  where user_id = auth.uid() and topic_id = p_topic_id;

  -- Return the standardized response
  return api.api_response(
    jsonb_build_object(
      'subscription',
      coalesce(row_to_json(result_record), '{}'::json)
    ),
    true,
    api.get_message('topics_subscribe_to_topic_succeeded')
  );
end;
$$;

-- Messages for fn_api_topics_subscribe_to_topic
INSERT INTO messages (key, message) VALUES
  ('topics_subscribe_to_topic_succeeded', 'تم الاشتراك في الموضوع بنجاح')
ON CONFLICT (key) DO UPDATE SET message = EXCLUDED.message;
