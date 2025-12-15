-- Function: fn_api_notifications_get_total_notifications_topics
-- Description: Gets all available notification topics
-- Parameters: None
-- Returns: JSONB with all notification topics data
create or replace function api.fn_api_notifications_get_total_notifications_topics()
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
      ),
      '[]'::json
    )
  ),
  true,
  api.get_message('notification_topics_retrieved')
);
$$;
