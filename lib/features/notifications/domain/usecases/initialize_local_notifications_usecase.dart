import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class InitializeLocalNotificationsUsecase {
  final NotificationsRepository repository;

  InitializeLocalNotificationsUsecase({required this.repository});

  Future<Either<Failure, Unit>> call() async {
    return await repository.initializeLocalNotification();
  }
}
