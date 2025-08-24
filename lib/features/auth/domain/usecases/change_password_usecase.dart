import 'package:bac_project/core/resources/errors/failures.dart';
import '../../data/responses/change_password_response.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

import '../requests/change_password_request.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase({required this.repository});

  Future<Either<Failure, ChangePasswordResponse>> call({
    required ChangePasswordRequest request,
  }) async {
    return await repository.changePassword(request: request);
  }
}
