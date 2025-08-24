import 'package:bac_project/features/notifications/domain/entities/app_notification.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class DisplayNotificationUsecase {
  final NotificationsRepository repository;

  DisplayNotificationUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({
    required AppNotification notification,
    bool oneTimeNotification = false,
    NotificationDetails? details,
  }) async {
    return await repository.displayNotification(
      notification: notification,
      oneTimeNotification: oneTimeNotification,
      details: details,
    );
  }
}
