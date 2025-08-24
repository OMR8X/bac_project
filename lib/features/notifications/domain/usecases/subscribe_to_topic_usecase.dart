import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class SubscribeToTopicUsecase {
  final NotificationsRepository repository;

  SubscribeToTopicUsecase({required this.repository});
  Future<Either<Failure, Unit>> call({required String topic}) async {
    return await repository.subscribeToTopic(topic: topic);
  }
}
