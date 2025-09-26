-- Function: fn_api_topics_subscribe_to_topic
-- Description: Subscribes a user to a notification topic
-- Parameters:
-- Returns:
-- drop function api.fn_api_topics_subscribe_to_topic;
create or replace function api.fn_api_topics_subscribe_to_topic(
  p_topic_id bigint
)
returns json
language sql
security definer
as $$
select api.api_response(
  data := (
    insert into user_topic_subscriptions (user_id, topic_id)
    values (auth.uid(), p_topic_id)
    on conflict (user_id, topic_id) do nothing
    returning row_to_json(user_topic_subscriptions)
  ),
  message := 'Successfully subscribed to topic'
);
$$;


