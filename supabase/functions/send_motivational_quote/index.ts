import { createClient } from 'jsr:@supabase/supabase-js@2';
import { sendBulkNotifications } from '../send_bulk_notification/fcm.ts';
import { DatabaseNotification } from '../send_bulk_notification/database_notification.ts';

interface MotivationalQuote {
  id: number;
  quote: string;
  author: string;
  used: boolean;
}

Deno.serve(async (_req: Request): Promise<Response> => {
  try {
    // Initialize Supabase client
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    // First, get the motivation topic details
    const { data: motivationTopic, error: topicError } = await supabase
      .from('notification_topics')
      .select('id, title, firebase_topic')
      .eq('firebase_topic', 'motivation')
      .eq('subscribable', true)
      .single();

    if (topicError || !motivationTopic) {
      return new Response(
        JSON.stringify({
          success: false,
          error: 'Motivation topic not found',
          details: topicError?.message
        }),
        {
          status: 404,
          headers: { 'Content-Type': 'application/json' }
        }
      );
    }

    // Query for a single unused motivational quote
    const { data: selectedQuote, error: queryError } = await supabase
      .from('motivational_quotes')
      .select('*')
      .eq('used', false)
      .limit(1)
      .single();

    // Check for query errors
    if (queryError || !selectedQuote) {
      return new Response(
        JSON.stringify({
          success: false,
          error: 'No motivational quotes available',
          details: queryError?.message
        }),
        {
          status: 404,
          headers: { 'Content-Type': 'application/json' }
        }
      );
    }

    // Create database notification object for FCM
    const dbNotification: DatabaseNotification = {
      topic_id: motivationTopic.id,
      title: `✍️ ${selectedQuote.author}`,
      body: selectedQuote.quote,
      priority: 'low' as const
    };

    // Call FCM directly using the same function as send_bulk_notification
    const notificationResult = await sendBulkNotifications(
      undefined, // no tokens, using topic
      dbNotification,
      motivationTopic.firebase_topic // topic name
    );

    // Check if notification was sent successfully
    const shouldMarkAsUsed = notificationResult.successCount > 0;

    // Mark the quote as used after successful notification
    // if (shouldMarkAsUsed) {
    //   await supabase
    //     .from('motivational_quotes')
    //     .update({
    //       used: true,
    //       updated_at: new Date().toISOString()
    //     })
    //     .eq('id', selectedQuote.id);
    // }

    // Return appropriate response based on notification success
    if (shouldMarkAsUsed) {
      return new Response(
        JSON.stringify({
          success: true,
          quote_id: selectedQuote.id,
          quote: selectedQuote.quote,
          author: selectedQuote.author,
          topic: {
            id: motivationTopic.id,
            title: motivationTopic.title,
            firebase_topic: motivationTopic.firebase_topic
          },
          notification_sent: true,
          notification_result: {
            success: notificationResult.successCount > 0,
            totalSent: notificationResult.successCount + notificationResult.failureCount,
            successCount: notificationResult.successCount,
            failureCount: notificationResult.failureCount,
            sentToTopic: notificationResult.sentToTopic
          }
        }),
        {
          headers: { 'Content-Type': 'application/json' }
        }
      );
    } else {
      return new Response(
        JSON.stringify({
          success: false,
          quote_id: selectedQuote.id,
          quote: selectedQuote.quote,
          author: selectedQuote.author,
          topic: {
            id: motivationTopic.id,
            title: motivationTopic.title,
            firebase_topic: motivationTopic.firebase_topic
          },
          notification_sent: false,
          error: 'Failed to send notification to FCM',
          notification_result: {
            success: notificationResult.successCount > 0,
            totalSent: notificationResult.successCount + notificationResult.failureCount,
            successCount: notificationResult.successCount,
            failureCount: notificationResult.failureCount,
            sentToTopic: notificationResult.sentToTopic,
            failures: notificationResult.failures
          }
        }),
        {
          status: 500,
          headers: { 'Content-Type': 'application/json' }
        }
      );
    }

  } catch (error) {
    const errorMessage = error instanceof Error ? error.message : 'Unknown error';

    return new Response(
      JSON.stringify({
        success: false,
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
