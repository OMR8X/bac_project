import 'package:bac_project/features/notifications/domain/requests/mark_notification_as_read_request.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class MarkNotificationAsReadUsecase {
  final NotificationsRepository repository;

  MarkNotificationAsReadUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(MarkNotificationAsReadRequest request) async {
    return await repository.markNotificationAsRead(request);
  }
}
