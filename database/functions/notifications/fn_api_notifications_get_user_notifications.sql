create or replace function api.fn_api_notifications_get_user_notifications(limit_param integer default 20, offset_param integer default 0)
returns jsonb
language sql
security definer
as $$
select api.api_response(
  jsonb_build_object(
    'notifications',
    coalesce(
      (select json_agg(notification_data) from (
        select
          json_build_object(
            'id', n.id,
            'title', n.title,
            'body', n.body,
            'image_url', n.image_url,
            'payload', n.payload,
            'priority', n.priority,
            'created_at', n.created_at::timestamptz,
            'expires_at', n.expires_at::timestamptz,
            'topic_id', n.topic_id,
            'topic_title', nt.title,
            'readed_at', un.readed_at
          ) as notification_data
        from notifications n
        join user_notifications un on un.notification_id = n.id
        left join notification_topics nt on nt.id = n.topic_id
        where un.user_id = auth.uid()
        order by n.created_at desc
        limit limit_param
        offset offset_param
      ) as ordered_notifications),
      '[]'::json
    )
  ),
  true,
  api.get_message('user_notifications_retrieved')
);
$$;



