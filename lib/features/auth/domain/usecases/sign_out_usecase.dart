import 'package:neuro_app/features/auth/data/responses/sign_out_response.dart';
import 'package:neuro_app/features/auth/domain/requests/sign_out_request.dart';

import 'package:neuro_app/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class SignOutUsecase {
  final AuthRepository repository;

  SignOutUsecase({required this.repository});

  Future<Either<Failure, SignOutResponse>> call({required SignOutRequest request}) async {
    return await repository.signOut(request: request);
  }
}
