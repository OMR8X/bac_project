import 'package:neuro_app/features/notifications/data/responses/get_user_subscribed_topics_response.dart';
import 'package:dartz/dartz.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class GetUserSubscribedTopicsUsecase {
  final NotificationsRepository repository;

  GetUserSubscribedTopicsUsecase({required this.repository});

  Future<Either<Failure, GetUserSubscribedTopicsResponse>> call() async {
    return await repository.getUserSubscribedTopics();
  }
}
