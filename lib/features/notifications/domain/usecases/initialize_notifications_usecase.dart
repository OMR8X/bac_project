import 'package:dartz/dartz.dart';

import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class InitializeNotificationsUsecase {
  final NotificationsRepository repository;

  InitializeNotificationsUsecase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.initializeNotification();
  }
}
