import 'package:bac_project/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_project/features/auth/domain/requests/get_user_data_request.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class GetUserDataUsecase {
  final AuthRepository repository;

  GetUserDataUsecase({required this.repository});

  Future<Either<Failure, GetUserDataResponse>> call({required GetUserDataRequest request}) async {
    return await repository.getUserData(request: request);
  }
}
