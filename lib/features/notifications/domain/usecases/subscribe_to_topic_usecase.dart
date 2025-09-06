import 'package:bac_project/features/notifications/data/responses/subscribe_to_topic_response.dart';
import 'package:bac_project/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class SubscribeToTopicUsecase {
  final NotificationsRepository repository;

  SubscribeToTopicUsecase({required this.repository});
  Future<Either<Failure, SubscribeToTopicResponse>> call(SubscribeToTopicRequest request) async {
    return await repository.subscribeToTopic(request);
  }
}
