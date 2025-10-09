# Notification Permissions and Action Permissions Guide

## Overview

This document explains when and how to use permissions in the notification system, with special focus on notification action permissions. The app uses Firebase Cloud Messaging (FCM) for push notifications and Flutter Local Notifications for local notifications.

## Permission Types

### 1. Notification Permissions

Notification permissions are required to receive and display notifications on the device.

#### When to Request Notification Permissions

**Always request permissions:**
- During app initialization
- When user explicitly enables notifications
- Before sending any local notification

**Never request permissions:**
- In background/terminated app states
- Without user interaction
- Multiple times in the same session

#### Permission Request Implementation

```dart
// Android permissions (using permission_handler)
if (Platform.isAndroid) {
  var status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  } else if (status.isPermanentlyDenied) {
    await openAppSettings(); // Direct user to settings
  }
}

// iOS permissions (using Firebase Messaging)
else if (Platform.isIOS) {
  await _firebaseMessaging.requestPermission(
    alert: true,      // Show alert notifications
    badge: true,      // Update app icon badge
    sound: true,      // Play notification sound
  );
}
```

#### Permission States

- **Granted**: Permission approved, notifications will work
- **Denied**: Permission rejected, can request again
- **Permanently Denied**: User selected "Don't ask again", redirect to app settings
- **Restricted/Limited**: iOS specific states (rare)

### 2. Notification Action Permissions

Notification actions allow users to interact with notifications without opening the app.

#### When to Use Notification Actions

**Use notification actions for:**
- Time-sensitive operations (cancel, pause, resume)
- Quick responses (yes/no, accept/decline)
- Common user workflows (mark as read, reply)

**Don't use notification actions for:**
- Complex operations requiring UI
- Operations needing user authentication
- Actions requiring network calls (use background tasks instead)

#### Action Permission Considerations

**Foreground Actions:**
- Available when app is running
- Immediate execution
- Can show UI if needed
- Use `DarwinNotificationActionOption.foreground`

**Background Actions:**
- Available when app is not running
- Limited execution time
- Cannot show UI
- Use default options (no foreground flag)

## Notification Action Types

### 1. Android Notification Actions

Defined dynamically through notification payload:

```json
{
  "actions": [
    {
      "label": "Accept"
    },
    {
      "label": "Decline"
    }
  ]
}
```

**Characteristics:**
- Up to 3 actions supported
- Actions identified by index (0, 1, 2...)
- `showsUserInterface: false` (no UI shown)
- `cancelNotification: false` (notification stays)

### 2. iOS Notification Categories

Pre-defined categories in app initialization:

```dart
DarwinNotificationCategory(
  'cancel_operation_category',
  actions: <DarwinNotificationAction>[
    DarwinNotificationAction.plain(
      'cancel_operation_button',
      'الغاء العملية',
      options: <DarwinNotificationActionOption>{
        DarwinNotificationActionOption.foreground,
      },
    ),
  ],
)
```

**Characteristics:**
- Categories defined at app start
- Actions have unique identifiers
- Support foreground/background options
- Localized action labels

## Implementation Examples

### Example 1: Progress Notification with Cancel Action

Used for long-running operations that user can cancel:

```dart
// Android implementation
static NotificationDetails progressNotificationsDetails({
  required int sent,
  required int total
}) {
  return NotificationDetails(
    android: AndroidNotificationDetails(
      defaultChannel.id,
      defaultChannel.name,
      showProgress: true,
      maxProgress: total,
      progress: sent,
      actions: [
        const AndroidNotificationAction(
          'cancel_operation_button',
          'الغاء العملية'
        )
      ],
    ),
    iOS: const DarwinNotificationDetails(
      categoryIdentifier: 'cancel_operation_category',
    ),
  );
}
```

### Example 2: Dynamic Actions from Payload

Used for notifications that need context-specific actions:

```dart
List<AndroidNotificationAction> androidActions() {
  final actionsList = payload!['actions'] as List<dynamic>;

  for (int i = 0; i < actionsList.length; i++) {
    final actionData = actionsList[i];
    final label = actionData['label']?.toString().trim();

    if (label != null && label.isNotEmpty) {
      actions.add(AndroidNotificationAction(
        i.toString(), // Action ID as string
        label,
        showsUserInterface: false,
        cancelNotification: false,
      ));
    }
  }
  return actions;
}
```

### Example 3: Handling Action Responses

Both foreground and background action responses are handled:

```dart
@pragma('vm:entry-point')
void onDidReceiveNotificationResponse(NotificationResponse? response) {
  if (response != null) {
    final actionId = response.actionId;
    final payload = response.payload;

    // Handle specific actions
    switch (actionId) {
      case 'cancel_operation_button':
        // Cancel the operation
        break;
      case '0': // First dynamic action
        // Handle first action
        break;
      case '1': // Second dynamic action
        // Handle second action
        break;
    }
  }
}
```

## Best Practices

### Permission Request Timing

1. **App Launch**: Request permissions during initialization
2. **User Action**: Request when user enables notifications
3. **Graceful Degradation**: App works without permissions

### Action Design Guidelines

1. **Limit Actions**: Maximum 3 actions per notification
2. **Clear Labels**: Use concise, descriptive action names
3. **Consistent IDs**: Use stable action identifiers
4. **Context Awareness**: Actions should be relevant to notification content

### Permission Handling Strategy

1. **Check Status First**: Always check permission status before requesting
2. **Handle Denial**: Provide clear feedback when permissions are denied
3. **Settings Redirect**: Guide users to settings for permanently denied permissions
4. **Platform Differences**: Handle Android and iOS permission flows differently

### Error Handling

```dart
try {
  await Permission.notification.request();
} on Exception catch (e) {
  // Log error but don't crash
  Logger.error('Permission request failed: $e');
  // Continue with reduced functionality
}
```

## Platform-Specific Considerations

### Android
- Uses `permission_handler` package
- Supports dynamic notification actions
- Permissions can be permanently denied
- Requires explicit permission request

### iOS
- Uses Firebase Messaging permission API
- Supports notification categories
- Permissions requested once (system handles)
- Supports foreground/background action options

## Troubleshooting

### Common Issues

1. **Actions not showing**: Check payload format and action limits
2. **Permissions denied**: Implement proper error handling and user guidance
3. **Background actions failing**: Ensure actions don't require UI or long operations

### Debugging Tips

- Check notification payload structure
- Verify action IDs match handlers
- Test on both platforms
- Monitor permission status changes

## Security Considerations

- Actions should not expose sensitive operations
- Background actions should validate user context
- Avoid actions that could compromise data integrity
- Implement proper authentication checks for critical actions
