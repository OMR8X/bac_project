import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/notifications_repository.dart';

class GetDeviceTokenUsecase {
  final NotificationsRepository repository;

  GetDeviceTokenUsecase({required this.repository});

  Future<Either<Failure, String?>> call() async {
    return await repository.getDeviceToken();
  }
}
