-- Setup motivational notifications cron job
-- This file sets up the pg_cron extension and schedules the motivational notifications

-- Enable the pg_cron extension (run this as superuser/admin)
-- CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Schedule the motivational notifications function to run every 10 minutes
-- Note: This requires pg_cron extension to be enabled
/*
SELECT cron.schedule(
  'send-motivational-notifications',           -- job name
  '*/10 * * * *',                              -- cron expression (every 10 minutes)
  'SELECT api.fn_schedule_motivational_notifications();'  -- SQL command to run
);
*/

-- Alternative: Schedule to run at specific times (e.g., every hour at :00, :10, :20, etc.)
-- This ensures notifications are sent at consistent times rather than every 10 minutes from startup
/*
SELECT cron.schedule(
  'send-motivational-notifications-hourly',
  '0,10,20,30,40,50 * * * *',  -- At minute 0, 10, 20, 30, 40, 50 of every hour
  'SELECT api.fn_schedule_motivational_notifications();'
);
*/

-- To unschedule the job (if needed):
-- SELECT cron.unschedule('send-motivational-notifications');

-- To view scheduled jobs:
-- SELECT * FROM cron.job;

-- To view job run history:
-- SELECT * FROM cron.job_run_details ORDER BY start_time DESC LIMIT 10;


