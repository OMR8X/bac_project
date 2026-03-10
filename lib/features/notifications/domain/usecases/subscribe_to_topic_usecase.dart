import 'package:neuro_app/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:dartz/dartz.dart';

import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class SubscribeToTopicUsecase {
  final NotificationsRepository repository;

  SubscribeToTopicUsecase({required this.repository});
  Future<Either<Failure, Unit>> call(SubscribeToTopicRequest request) async {
    return await repository.subscribeToTopic(request);
  }
}
