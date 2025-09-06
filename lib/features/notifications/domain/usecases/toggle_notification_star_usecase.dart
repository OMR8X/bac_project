import 'package:bac_project/features/notifications/data/responses/toggle_notification_star_response.dart';
import 'package:bac_project/features/notifications/domain/requests/toggle_notification_star_request.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class ToggleNotificationStarUsecase {
  final NotificationsRepository repository;

  ToggleNotificationStarUsecase({required this.repository});

  Future<Either<Failure, ToggleNotificationStarResponse>> call(ToggleNotificationStarRequest request) async {
    return await repository.toggleNotificationStar(request);
  }
}
