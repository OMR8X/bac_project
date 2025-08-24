import 'package:bac_project/features/auth/data/responses/get_user_favorites_response.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class GetUserFavoritesUsecase {
  final AuthRepository repository;

  GetUserFavoritesUsecase({required this.repository});

  Future<Either<Failure, GetUserFavoritesResponse>> call() async {
    return await repository.getUserFavorites();
  }
}
