import 'package:bac_project/features/auth/data/responses/update_password_response.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import '../requests/update_password_request.dart';

class UpdatePasswordUsecase {
  final AuthRepository repository;

  UpdatePasswordUsecase({required this.repository});

  Future<Either<Failure, UpdatePasswordResponse>> call({
    required UpdatePasswordRequest request,
  }) async {
    return await repository.updatePassword(request: request);
  }
}
