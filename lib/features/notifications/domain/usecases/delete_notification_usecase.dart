import 'package:bac_project/features/notifications/data/responses/update_notification_status_response.dart';
import 'package:bac_project/features/notifications/domain/requests/update_notification_status_request.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class DeleteNotificationUsecase {
  final NotificationsRepository repository;

  DeleteNotificationUsecase({required this.repository});

  Future<Either<Failure, UpdateNotificationStatusResponse>> call(UpdateNotificationStatusRequest request) async {
    return await repository.deleteNotification(request);
  }
}
