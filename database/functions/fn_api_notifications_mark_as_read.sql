-- Function: fn_api_notifications_mark_as_read
-- Description: Marks a user notification as read
-- Parameters:
-- Returns:
create or replace function api.fn_api_notifications_mark_as_read(
  p_notification_id bigint
)
returns json
language sql
security definer
as $$
select api.api_response(
  data := (
    update user_notifications
    set read_at = now()
    where user_id = auth.uid()
      and notification_id = p_notification_id
    returning row_to_json(user_notifications)
  ),
  message := 'Notification marked as read successfully'
);
$$;