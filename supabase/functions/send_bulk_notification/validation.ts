import { SendNotificationRequest, ValidationError } from './types.ts';

export function validateNotificationRequest(requestBody: unknown): SendNotificationRequest | ValidationError {
  // Type guard for request body
  if (!requestBody || typeof requestBody !== 'object') {
    return {
      error: 'Invalid request body',
      status: 400
    };
  }

  const body = requestBody as Record<string, unknown>;

  // Validate that either tokens or topic is provided, but not both or neither
  const hasTokens = body.tokens && Array.isArray(body.tokens) && body.tokens.length > 0;
  const hasTopic = body.topic && typeof body.topic === 'string' && (body.topic as string).trim().length > 0;

  if (!hasTokens && !hasTopic) {
    return {
      error: 'Either tokens array or topic must be provided',
      status: 400
    };
  }

  if (hasTokens && hasTopic) {
    return {
      error: 'Cannot provide both tokens and topic. Choose one method.',
      status: 400
    };
  }

  // Validate tokens if provided
  if (hasTokens) {
    const tokens = body.tokens as unknown[];
    const invalidTokens = tokens.filter((token: unknown) => !token || typeof token !== 'string');
    if (invalidTokens.length > 0) {
      return {
        error: 'All tokens must be non-empty strings',
        status: 400
      };
    }
  }

  // Validate topic if provided
  if (hasTopic) {
    // Basic topic validation - FCM topics have restrictions
    const topicRegex = /^[a-zA-Z0-9_-]+$/;
    const topic = body.topic as string;
    if (!topicRegex.test(topic)) {
      return {
        error: 'Topic name can only contain letters, numbers, hyphens, and underscores',
        status: 400
      };
    }
  }

  // Validate notification data
  if (!body.notification) {
    return {
      error: 'Missing notification data',
      status: 400
    };
  }

  // Additional validation for notification structure
  const notification = body.notification as Record<string, unknown>;
  if (!notification.title || !notification.body) {
    return {
      error: 'Notification must have title and body',
      status: 400
    };
  }

  return body as unknown as SendNotificationRequest;
}
