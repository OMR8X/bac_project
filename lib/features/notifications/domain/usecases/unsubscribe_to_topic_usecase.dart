
import 'package:bac_project/features/notifications/domain/requests/unsubscribe_from_topic_request.dart';
import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class UnsubscribeToTopicUsecase {
  final NotificationsRepository repository;

  UnsubscribeToTopicUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(UnsubscribeFromTopicRequest request) async {
    return await repository.unsubscribeToTopic(request);
  }
}
