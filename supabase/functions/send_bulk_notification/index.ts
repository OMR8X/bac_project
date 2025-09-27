import { JWT } from 'npm:google-auth-library@9'
import { 
  DatabaseNotification, 
  NotificationPriority 
} from './database_notification.ts'

// Load Firebase service account from Supabase secret
const serviceAccount = JSON.parse(Deno.env.get('FIREBASE_SERVICE_ACCOUNT')!);

interface SendNotificationRequest {
  tokens: string[];
  notification: DatabaseNotification;
}

interface FCMMessage {
  token: string;
  notification: {
    title: string;
    body: string;
    image?: string;
  };
  data?: Record<string, string>;
  android: {
    priority: string;
  };
  apns: {
    headers: {
      'apns-priority': string;
    };
  };
}

interface FCMResponse {
  name?: string;
  error?: {
    code: number;
    message: string;
    status: string;
  };
}

Deno.serve(async (req: Request) => {
  try {
    // Parse request body
    const requestBody: SendNotificationRequest = await req.json();
    
    if (!requestBody.tokens || !Array.isArray(requestBody.tokens) || requestBody.tokens.length === 0) {
      return new Response(
        JSON.stringify({ error: 'Invalid or missing tokens array' }), 
        { status: 400, headers: { 'Content-Type': 'application/json' } }
      );
    }

    if (!requestBody.notification) {
      return new Response(
        JSON.stringify({ error: 'Missing notification data' }), 
        { status: 400, headers: { 'Content-Type': 'application/json' } }
      );
    }

    // Get Firebase access token
    const accessToken = await getAccessToken({
      clientEmail: serviceAccount.client_email,
      privateKey: serviceAccount.private_key,
    });

    // Prepare FCM messages for all tokens
    const fcmMessages: FCMMessage[] = requestBody.tokens.map(token => 
      createFCMMessage(token, requestBody.notification)
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
        token: requestBody.tokens[index],
        error: result.status === 'rejected' ? result.reason : null
      }));

    return new Response(JSON.stringify({
      success: true,
      totalSent: requestBody.tokens.length,
      successCount,
      failureCount,
      failures: failures.length > 0 ? failures : undefined
    }), {
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

// Create FCM message from database notification following the template structure
function createFCMMessage(token: string, notification: DatabaseNotification): FCMMessage {
  const message: FCMMessage = {
    token: token, // {{TOKEN}}
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

// Map database notification priority to Android FCM priority
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

// Map database notification priority to APNS priority
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

// Send a single notification to FCM
async function sendSingleNotification(message: FCMMessage, accessToken: string): Promise<FCMResponse> {
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

// Helper to get Firebase access token
const getAccessToken = ({
  clientEmail,
  privateKey,
}: {
  clientEmail: string
  privateKey: string
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
