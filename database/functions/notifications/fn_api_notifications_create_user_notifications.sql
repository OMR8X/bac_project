-- Function: fn_api_notifications_create_user_notifications
-- Description: Creates user notification links either by direct user IDs or topic subscribers
-- Parameters:
--   p_notification_id - ID of the notification to link
--   p_user_ids - Optional array of user IDs to link directly
--   p_topic_id - Optional topic ID to find subscribers
-- Returns: jsonb response with operation details
create or replace function api.fn_api_notifications_create_user_notifications(
  p_notification_id bigint,
  p_user_ids uuid[] default null,
  p_topic_id bigint default null
)
returns jsonb
language plpgsql
security definer
as $$
declare
  target_users uuid[];
  notification_exists boolean;
  topic_exists boolean;
  inserted_count int := 0;
  method_used text;
begin

  -- Validation: Check if notification exists
  select exists(
    select 1 from notifications where id = p_notification_id
  ) into notification_exists;

  if not notification_exists then
    return api.api_response(
      jsonb_build_object('error', 'notification_not_found'),
      false,
      api.get_message('notification_not_found')
    );
  end if;

  -- Validation: Ensure exactly one of user_ids or topic_id is provided
  if (p_user_ids is not null and p_topic_id is not null) then
    return api.api_response(
      jsonb_build_object('error', 'invalid_parameters'),
      false,
      api.get_message('cannot_provide_both_user_ids_and_topic_id')
    );
  end if;

  if (p_user_ids is null and p_topic_id is null) then
    return api.api_response(
      jsonb_build_object('error', 'missing_parameters'),
      false,
      api.get_message('must_provide_user_ids_or_topic_id')
    );
  end if;

  -- Method 1: Direct user IDs provided
  if p_user_ids is not null then
    -- Validate that users exist
    select array_agg(u.id)
    into target_users
    from unnest(p_user_ids) as input_user_id
    join auth.users u on u.id = input_user_id;

    if array_length(target_users, 1) != array_length(p_user_ids, 1) then
      return api.api_response(
        jsonb_build_object('error', 'invalid_users'),
        false,
        api.get_message('some_user_ids_do_not_exist')
      );
    end if;

    method_used := 'direct_users';

  -- Method 2: Topic ID provided - find subscribers
  else
    -- Validate that topic exists
    select exists(
      select 1 from notification_topics where id = p_topic_id
    ) into topic_exists;

    if not topic_exists then
      return api.api_response(
        jsonb_build_object('error', 'topic_not_found'),
        false,
        api.get_message('topic_not_found')
      );
    end if;

    -- Get subscribers to this topic
    select array_agg(u.id)
    into target_users
    from auth.users u
    join user_topic_subscriptions uts on uts.user_id = u.id and uts.topic_id = p_topic_id;

    method_used := 'topic_subscribers';
  end if;

  -- Perform bulk insert with conflict handling
  if target_users is not null and array_length(target_users, 1) > 0 then
    insert into user_notifications (user_id, notification_id)
    select unnest(target_users), p_notification_id
    on conflict (user_id, notification_id) do nothing;

    get diagnostics inserted_count = row_count;
  end if;

  -- Return success response
  return api.api_response(
    jsonb_build_object(
      'inserted_count', inserted_count,
      'method', method_used,
      'target_user_count', coalesce(array_length(target_users, 1), 0)
    ),
    true,
    api.get_message('notification_links_created')
  );

end;
$$;
