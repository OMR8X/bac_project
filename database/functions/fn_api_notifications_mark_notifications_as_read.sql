-- Function: fn_api_notifications_mark_notifications_as_read
-- Description: Marks multiple user notifications as read
-- Parameters: p_notification_ids - array of notification IDs to mark as read
-- Returns: jsonb response with update count
create or replace function api.fn_api_notifications_mark_notifications_as_read(
  p_notification_ids bigint[]
)
returns jsonb
language plpgsql
security definer
as $$
declare
  updated_count int;
begin
  -- Perform the bulk update
  update user_notifications
  set read_at = now()
  where user_id = auth.uid()
    and notification_id = ANY(p_notification_ids);

  -- Get count of updated records
  GET DIAGNOSTICS updated_count = ROW_COUNT;

  -- Return the standardized response
  return api.api_response(
    jsonb_build_object('updated_count', updated_count),
    'ok'::text,
    format('Successfully marked %s notifications as read', updated_count)::text
  );
end;
$$;
