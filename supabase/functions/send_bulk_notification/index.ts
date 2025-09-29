import { validateNotificationRequest } from './validation.ts';
import { sendBulkNotifications } from './fcm.ts';
import { BulkNotificationResult } from './types.ts';



Deno.serve(async (req: Request): Promise<Response> => {
  try {
    // Parse and validate request body
    const requestBody = await req.json();
    const validationResult = validateNotificationRequest(requestBody);

    // Check if validation failed
    if ('error' in validationResult) {
      return new Response(
        JSON.stringify({ error: validationResult.error }),
        {
          status: validationResult.status,
          headers: { 'Content-Type': 'application/json' }
        }
      );
    }

    const { tokens, topic, notification } = validationResult;

    // Send bulk notifications
    const { successCount, failureCount, failures, sentToTopic } = await sendBulkNotifications(
      tokens,
      notification,
      topic
    );

    // Prepare response
    const result: BulkNotificationResult = {
      success: true,
      totalSent: sentToTopic ? 1 : (tokens?.length || 0),
      successCount,
      failureCount,
      failures: failures.length > 0 ? failures : undefined,
      topic: sentToTopic ? topic : undefined
    };

    return new Response(JSON.stringify(result), {
      headers: { 'Content-Type': 'application/json' },
    });

  } catch (error) {
    console.error('Error processing bulk notification request:', error);
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';

    return new Response(
      JSON.stringify({
        error: 'Internal server error',
        message: errorMessage
      }),
      {
        status: 500,
        headers: { 'Content-Type': 'application/json' }
      }
    );
  }
});
