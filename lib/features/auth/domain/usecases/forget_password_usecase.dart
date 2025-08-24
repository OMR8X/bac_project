

import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import '../../data/responses/forget_password_response.dart';
import '../repositories/auth_repository.dart';
import '../requests/forget_password_request.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase({required this.repository});

  Future<Either<Failure, ForgetPasswordResponse>> call({
    required ForgetPasswordRequest request,
  }) async {
    return await repository.forgetPassword(request: request);
  }
}
