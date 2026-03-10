import 'package:dartz/dartz.dart';

import 'package:neuro_app/core/resources/errors/failures.dart';
import 'package:neuro_app/features/notifications/domain/requests/get_notifications_request.dart';
import '../repositories/notifications_repository.dart';
import 'package:neuro_app/features/notifications/data/responses/get_notifications_response.dart';

class GetNotificationsUsecase {
  final NotificationsRepository repository;

  GetNotificationsUsecase({required this.repository});

  Future<Either<Failure, GetNotificationsResponse>> call(GetNotificationsRequest request) async {
    return await repository.getNotifications(request);
  }
}
