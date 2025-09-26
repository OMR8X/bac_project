-- Function: fn_api_topics_get_user_subscribed_topics
-- Description: Gets all topics a user is subscribed to including default topics
-- Parameters:
-- Returns:
create or replace function api.fn_api_topics_get_user_subscribed_topics()
returns json
language sql
security definer
as $$
select api.api_response(
  data := coalesce(
    (
      select json_agg(row_to_json(t))
      from (
        select
          nt.id,
          nt.name,
          nt.description
        from notification_topics nt
        join user_topic_subscriptions uts
          on uts.topic_id = nt.id
        where uts.user_id = auth.uid()
      ) t
    ),
    '[]'::json
  ),
  message := 'User subscribed topics retrieved successfully'
);
$$;
