import 'package:bac_project/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_project/features/auth/domain/requests/sign_up_request.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class SignUpUsecase {
  final AuthRepository repository;

  SignUpUsecase({required this.repository});

  Future<Either<Failure, SignUpResponse>> call({required SignUpRequest request}) async {
    return await repository.signUp(request: request);
  }
}
