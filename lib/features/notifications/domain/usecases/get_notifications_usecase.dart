import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/domain/requests/get_notifications_request.dart';
import '../entities/app_notification.dart';
import '../repositories/notifications_repository.dart';
import 'package:bac_project/features/notifications/data/responses/get_notifications_response.dart';

class GetNotificationsUsecase {
  final NotificationsRepository repository;

  GetNotificationsUsecase({required this.repository});

  Future<Either<Failure, GetNotificationsResponse>> call(GetNotificationsRequest request) async {
    return await repository.getNotifications(request);
  }
}
