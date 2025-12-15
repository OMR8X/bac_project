-- Function: fn_api_topics_get_user_subscribed_topics
-- Description: Gets all topics a user is subscribed to including default topics
-- Parameters:
-- Returns: JSONB with subscribed topics data
create or replace function api.fn_api_topics_get_user_subscribed_topics()
returns jsonb
language sql
security definer
as $$
select api.api_response(
  jsonb_build_object(
    'topics',
    coalesce(
      (
        select json_agg(
          json_build_object(
            'id', nt.id,
            'title', nt.title,
            'description', nt.description,
            'firebase_topic', nt.firebase_topic,
            'subscribable', nt.subscribable
          )
          order by nt.id
        )
        from notification_topics nt
        join user_topic_subscriptions uts
          on uts.topic_id = nt.id
        where uts.user_id = auth.uid()
      ),
      '[]'::json
    )
  ),
  true,
  api.get_message('user_subscribed_topics_retrieved')
);
$$;
