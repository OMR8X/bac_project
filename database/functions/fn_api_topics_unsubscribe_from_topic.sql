-- Function: fn_api_topics_unsubscribe_from_topic
-- Description: Unsubscribes a user from a notification topic
-- Parameters:
-- Returns:
create or replace function api.fn_api_topics_unsubscribe_from_topic(
  p_topic_id bigint
)
returns json
language sql
security definer
as $$
delete from user_topic_subscriptions
where user_id = auth.uid()
  and topic_id = p_topic_id
returning row_to_json(user_topic_subscriptions);  
$$;




