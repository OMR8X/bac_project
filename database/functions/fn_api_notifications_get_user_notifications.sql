create or replace function api.fn_api_notifications_get_user_notifications()
returns jsonb
language sql
security definer
as $$
select api.api_response(
coalesce(
(
  select json_agg(
	json_build_object(
	  'id', n.id,
	  'title', n.title,
	  'body', n.body,
	  'image_url', n.image_url,
	  'action_type', n.action_type,
	  'action_value', n.action_value,
	  'payload', n.payload,
	  'priority', n.priority,
	  'created_at', n.created_at,
	  'expires_at', n.expires_at,
	  'topic_id', n.topic_id,
	  'topic_title', nt.title,
	  'delivered_at', un.delivered_at,
	  'read_at', un.read_at,
	  'dismissed_at', un.dismissed_at,
	  'action_performed', un.action_performed
	)
	order by n.created_at desc
  )
  from notifications n
  join user_notifications un
	on un.notification_id = n.id
  left join notification_topics nt
	on nt.id = n.topic_id
  where un.user_id = auth.uid()
),
'[]'::json
)::jsonb,
'ok'::text,
'User notifications retrieved successfully'::text
);
$$;



