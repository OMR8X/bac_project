import 'package:neuro_app/features/notifications/data/responses/get_notifications_topics_response.dart';
import 'package:dartz/dartz.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class GetNotificationsTopicsUsecase {
  final NotificationsRepository repository;

  GetNotificationsTopicsUsecase({required this.repository});

  Future<Either<Failure, GetNotificationsTopicsResponse>> call() async {
    return await repository.getNotificationsTopics();
  }
}
