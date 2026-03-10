import 'package:neuro_app/features/auth/data/responses/update_user_data_response.dart';

import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../requests/update_user_data_request.dart';

class UpdateUserDataUsecase {
  final AuthRepository repository;

  UpdateUserDataUsecase({required this.repository});

  Future<Either<Failure, UpdateUserDataResponse>> call({
    required UpdateUserDataRequest request,
  }) async {
    return await repository.updateUserData(request: request);
  }
}
