import 'package:bac_project/features/notifications/data/responses/get_user_subscribed_topics_response.dart';
import 'package:bac_project/features/notifications/domain/requests/get_user_subscribed_topics_request.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class GetUserSubscribedTopicsUsecase {
  final NotificationsRepository repository;

  GetUserSubscribedTopicsUsecase({required this.repository});

  Future<Either<Failure, GetUserSubscribedTopicsResponse>> call(GetUserSubscribedTopicsRequest request) async {
    return await repository.getUserSubscribedTopics(request);
  }
}
