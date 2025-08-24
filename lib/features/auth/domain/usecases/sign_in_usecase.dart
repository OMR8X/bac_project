import 'package:bac_project/features/auth/data/responses/sign_in_response.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';
import '../requests/sign_in_request.dart';

import 'package:dartz/dartz.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<Either<Failure, SignInResponse>> call({required SignInRequest request}) async {
    return await repository.signIn(request: request);
  }
}
