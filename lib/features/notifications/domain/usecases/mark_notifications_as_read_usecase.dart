import 'package:neuro_app/features/notifications/domain/requests/mark_notifications_as_read_request.dart';
import 'package:dartz/dartz.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class MarkNotificationsAsReadUsecase {
  final NotificationsRepository repository;

  MarkNotificationsAsReadUsecase({required this.repository});

  Future<Either<Failure, Unit>> call(MarkNotificationsAsReadRequest request) async {
    return await repository.markNotificationsAsRead(request);
  }
}
