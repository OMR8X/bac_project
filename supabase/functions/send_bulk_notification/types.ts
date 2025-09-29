import { DatabaseNotification } from './database_notification.ts';

export interface SendNotificationRequest {
  tokens?: string[];
  topic?: string;
  notification: DatabaseNotification;
}

export interface FCMMessage {
  token?: string;
  topic?: string;
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

export interface FCMResponse {
  name?: string;
  error?: {
    code: number;
    message: string;
    status: string;
  };
}

export interface BulkNotificationResult {
  success: boolean;
  totalSent: number;
  successCount: number;
  failureCount: number;
  failures?: Array<{
    token: string;
    error: Error | string;
  }>;
  topic?: string; // For topic-based notifications
}

export interface ValidationError {
  error: string;
  status: number;
}
