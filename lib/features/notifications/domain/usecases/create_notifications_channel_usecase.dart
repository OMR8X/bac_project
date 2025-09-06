import 'package:dartz/dartz.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:bac_project/core/resources/errors/failures.dart';

import '../repositories/notifications_repository.dart';

class CreateNotificationsChannelUsecase {
  final NotificationsRepository repository;

  CreateNotificationsChannelUsecase({required this.repository});

  Future<Either<Failure, Unit>> call({required AndroidNotificationChannel channel}) async {
    return await repository.createNotificationsChannel(channel: channel);
  }
}
