// ===========================================
// DATABASE NOTIFICATION TYPES
// ===========================================

export type NotificationPriority = 'low' | 'normal' | 'high' | 'urgent';

export type NotificationActionType =
  | 'deeplink'          // Handle any deep link (internal app navigation or external URLs)
  | 'dismiss';          // Dismiss notification

export interface NotificationAction {
  id: string;           // Unique identifier for the action
  type: NotificationActionType;
  value?: string;       // Action parameter (deep link URL, reply context, etc.)
  title: string;        // Display title for the action button
}

export interface NotificationPayload {
  actions?: NotificationAction[];     // Available action buttons
  default_action?: string;            // ID of default action (when notification tapped)
  metadata?: Record<string, string | number | boolean>; // Additional data
}

export interface DatabaseNotification {
  id?: number;
  topic_id: number;
  title: string;
  body: string;
  image_url?: string;
  payload?: NotificationPayload;
  priority: NotificationPriority;
  created_at?: string;
  expires_at?: string;
}