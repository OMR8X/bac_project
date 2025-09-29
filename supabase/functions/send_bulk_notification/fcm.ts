import { JWT } from 'npm:google-auth-library@9';
import { DatabaseNotification, NotificationPriority } from './database_notification.ts';
import { FCMMessage, FCMResponse } from './types.ts';

// Load Firebase service account from Supabase secret
const serviceAccount = JSON.parse(Deno.env.get('FIREBASE_SERVICE_ACCOUNT')!);

/**
 * Create FCM message from database notification following the template structure
 */
export function createFCMMessage(tokenOrTopic: string, notification: DatabaseNotification, isTopic = false): FCMMessage {
  const message: FCMMessage = {
    ...(isTopic ? { topic: tokenOrTopic } : { token: tokenOrTopic }), // {{TOKEN}} or {{TOPIC}}
    notification: {
      title: notification.title, // {{TITLE}}
      body: notification.body, // {{BODY}}
    },
    android: {
      priority: mapPriorityToAndroid(notification.priority), // {{PRIORITY}}
    },
    apns: {
      headers: {
        'apns-priority': mapPriorityToAPNS(notification.priority), // {{APNS_PRIORITY}}
      },
    },
  };

  // Add image if provided - {{IMAGE_URL}}
  if (notification.image_url) {
    message.notification.image = notification.image_url;
  }

  // Add data payload if provided - {{DATA_KEY}}: {{DATA_VALUE}}
  if (notification.payload?.metadata) {
    message.data = {};
    Object.entries(notification.payload.metadata).forEach(([key, value]) => {
      message.data![key] = String(value);
    });
  }

  // Add notification actions as data if present
  if (notification.payload?.actions) {
    if (!message.data) message.data = {};
    message.data.actions = JSON.stringify(notification.payload.actions);
  }

  // Add default action if present
  if (notification.payload?.default_action) {
    if (!message.data) message.data = {};
    message.data.default_action = notification.payload.default_action;
  }

  return message;
}

/**
 * Map database notification priority to Android FCM priority
 */
function mapPriorityToAndroid(priority: NotificationPriority): string {
  switch (priority) {
    case 'low':
      return 'normal';
    case 'normal':
      return 'normal';
    case 'high':
    case 'urgent':
      return 'high';
    default:
      return 'normal';
  }
}

/**
 * Map database notification priority to APNS priority
 */
function mapPriorityToAPNS(priority: NotificationPriority): string {
  switch (priority) {
    case 'low':
      return '5';
    case 'normal':
      return '5';
    case 'high':
    case 'urgent':
      return '10';
    default:
      return '5';
  }
}

/**
 * Send a single notification to FCM
 */
export async function sendSingleNotification(message: FCMMessage, accessToken: string): Promise<FCMResponse> {
  const response = await fetch(
    `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${accessToken}`,
      },
      body: JSON.stringify({ message }),
    }
  );

  const responseData = await response.json();

  if (response.status < 200 || response.status > 299) {
    throw new Error(`FCM Error: ${responseData.error?.message || 'Unknown error'}`);
  }

  return responseData;
}

/**
 * Get Firebase access token using service account credentials
 */
export const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string;
  privateKey: string;
}): Promise<string> => {
  return new Promise((resolve, reject) => {
    const jwtClient = new JWT({
      email: clientEmail,
      key: privateKey,
      scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
    });
    jwtClient.authorize((err, tokens) => {
      if (err) {
        reject(err);
        return;
      }
      resolve(tokens!.access_token!);
    });
  });
};

/**
 * Send notifications to either multiple tokens or a topic
 */
export async function sendBulkNotifications(
  tokens: string[] | undefined,
  notification: DatabaseNotification,
  topic?: string
): Promise<{
  successCount: number;
  failureCount: number;
  failures: Array<{ token: string; error: Error | string }>;
  sentToTopic?: boolean;
}> {
  // Get Firebase access token
  const accessToken = await getAccessToken({
    clientEmail: serviceAccount.client_email,
    privateKey: serviceAccount.private_key,
  });

  // Handle topic-based sending
  if (topic) {
    try {
      const fcmMessage = createFCMMessage(topic, notification, true);
      await sendSingleNotification(fcmMessage, accessToken);
      return {
        successCount: 1,
        failureCount: 0,
        failures: [],
        sentToTopic: true
      };
    } catch (error) {
      return {
        successCount: 0,
        failureCount: 1,
        failures: [{ token: topic, error: error as Error }],
        sentToTopic: true
      };
    }
  }

  // Handle token-based sending
  if (!tokens || tokens.length === 0) {
    throw new Error('Either tokens or topic must be provided');
  }

  // Prepare FCM messages for all tokens
  const fcmMessages: FCMMessage[] = tokens.map(token =>
    createFCMMessage(token, notification, false)
  );

  // Send notifications to all tokens
  const results = await Promise.allSettled(
    fcmMessages.map(message => sendSingleNotification(message, accessToken))
  );

  // Process results
  const successCount = results.filter(result => result.status === 'fulfilled').length;
  const failureCount = results.filter(result => result.status === 'rejected').length;

  const failures = results
    .map((result, index) => ({ result, index }))
    .filter(({ result }) => result.status === 'rejected')
    .map(({ result, index }) => ({
      token: tokens[index],
      error: result.status === 'rejected' ? result.reason : null
    }));

  return {
    successCount,
    failureCount,
    failures,
    sentToTopic: false
  };
}
