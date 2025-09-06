import 'package:bac_project/features/notifications/data/responses/update_notification_status_response.dart';
import 'package:bac_project/features/notifications/domain/requests/update_notification_status_request.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

@Deprecated('Use MarkNotificationAsReadUsecase instead')
class MarkNotificationSeen {
  final NotificationsRepository repository;

  MarkNotificationSeen({required this.repository});

  @Deprecated('Use MarkNotificationAsReadUsecase instead')
  Future<Either<Failure, UpdateNotificationStatusResponse>> call(UpdateNotificationStatusRequest request) async {
    return await repository.markNotificationAsSeen(request);
  }
}
