import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class DisplayFirebaseNotificationUsecase {
  final NotificationsRepository repository;

  DisplayFirebaseNotificationUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({required RemoteMessage message}) async {
    return await repository.displayFirebaseNotification(message: message);
  }
}
