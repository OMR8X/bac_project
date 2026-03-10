import 'package:neuro_app/core/resources/errors/failures.dart';
import 'package:neuro_app/features/auth/data/responses/add_to_user_favorites_response.dart';
import 'package:neuro_app/features/auth/domain/requests/add_to_user_favorites_request.dart';
import '../repositories/auth_repository.dart';

import 'package:dartz/dartz.dart';

class AddToUserFavoritesUsecase {
  final AuthRepository repository;

  AddToUserFavoritesUsecase({required this.repository});

  Future<Either<Failure, AddToUserFavoritesResponse>> call({
    required AddToUserFavoritesRequest request,
  }) async {
    return await repository.addToUserFavorites(request: request);
  }
}
