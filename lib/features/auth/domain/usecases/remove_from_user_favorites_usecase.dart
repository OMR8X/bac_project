import 'package:bac_project/features/auth/data/responses/remove_from_user_favorites_response.dart';
import 'package:bac_project/features/auth/domain/requests/remove_from_user_favorites_request.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/api/responses/api_response.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class RemoveFromUserFavoritesUsecase {
  final AuthRepository repository;

  RemoveFromUserFavoritesUsecase({required this.repository});

  Future<Either<Failure, RemoveFromUserFavoritesResponse>> call({
    required RemoveFromUserFavoritesRequest request,
  }) async {
    return await repository.removeFromUserFavorites(request: request);
  }
}
