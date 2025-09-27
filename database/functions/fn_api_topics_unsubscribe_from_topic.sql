-- Function: fn_api_topics_unsubscribe_from_topic
-- Description: Unsubscribes a user from a notification topic
-- Parameters:
-- Returns:
create or replace function api.fn_api_topics_unsubscribe_from_topic(
  p_topic_id bigint
)
returns jsonb
language plpgsql
security definer
as $$
declare
  result_record record;
begin
  -- Get the subscription record before deletion
  select * into result_record
  from user_topic_subscriptions
  where user_id = auth.uid() and topic_id = p_topic_id;

  -- Perform the deletion
  delete from user_topic_subscriptions
  where user_id = auth.uid()
    and topic_id = p_topic_id;

  -- Return the standardized response
  return api.api_response(
    coalesce(row_to_json(result_record), '{}'::json)::jsonb,
    'ok'::text,
    'Successfully unsubscribed from topic'::text
  );
end;
$$;




