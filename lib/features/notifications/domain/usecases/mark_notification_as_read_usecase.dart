import 'package:bac_project/features/notifications/data/responses/update_notification_status_response.dart';
import 'package:bac_project/features/notifications/domain/requests/update_notification_status_request.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class MarkNotificationAsReadUsecase {
  final NotificationsRepository repository;

  MarkNotificationAsReadUsecase({required this.repository});

  Future<Either<Failure, UpdateNotificationStatusResponse>> call(UpdateNotificationStatusRequest request) async {
    return await repository.markNotificationAsRead(request);
  }
}
