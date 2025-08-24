import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class ClearNotificationsUsecase {
  final NotificationsRepository repository;

  ClearNotificationsUsecase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.clearNotifications();
  }
}
