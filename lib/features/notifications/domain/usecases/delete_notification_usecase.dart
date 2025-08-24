import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class DeleteNotificationUsecase {
  final NotificationsRepository repository;

  DeleteNotificationUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({required int notificationId}) async {
    return await repository.deleteNotification(notificationId: notificationId);
  }
}
