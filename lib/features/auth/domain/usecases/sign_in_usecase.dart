import 'package:neuro_app/features/auth/data/responses/sign_in_response.dart';

import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';
import '../requests/sign_in_request.dart';

import 'package:dartz/dartz.dart';

class SignInUsecase {
  final AuthRepository repository;

  SignInUsecase({required this.repository});

  Future<Either<Failure, SignInResponse>> call({required SignInRequest request}) async {
    return await repository.signIn(request: request);
  }
}
