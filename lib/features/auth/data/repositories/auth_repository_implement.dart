import 'dart:async';
import 'dart:convert';

import 'package:bac_project/core/resources/errors/error_mapper.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/services/cache/cache_constant.dart';
import 'package:bac_project/core/services/cache/cache_manager.dart';
import 'package:bac_project/core/services/tokens/tokens_manager.dart';
import 'package:bac_project/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:bac_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bac_project/features/auth/data/mappers/user_data_mapper.dart';
import 'package:bac_project/features/auth/data/responses/change_password_response.dart';
import 'package:bac_project/features/auth/data/responses/forget_password_response.dart';
import 'package:bac_project/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_project/features/auth/data/responses/remove_from_user_favorites_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_in_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_out_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_project/features/auth/data/responses/update_user_data_response.dart';
import 'package:bac_project/features/auth/domain/requests/add_to_user_favorites_request.dart';
import 'package:bac_project/features/auth/domain/requests/get_user_data_request.dart';
import 'package:bac_project/features/auth/domain/requests/remove_from_user_favorites_request.dart';
import 'package:bac_project/features/auth/domain/requests/sign_out_request.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/requests/change_password_request.dart';
import '../../domain/requests/forget_password_request.dart';
import '../../domain/requests/sign_in_request.dart';
import '../../domain/requests/sign_up_request.dart';
import '../../domain/requests/update_user_data_request.dart';
import '../responses/add_to_user_favorites_response.dart';
import '../responses/get_user_favorites_response.dart';

class AuthRepositoryImplement implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final CacheManager cacheManager;

  AuthRepositoryImplement({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.cacheManager,
  });

  @override
  Future<Either<Failure, ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest request,
  }) async {
    try {
      final response = await remoteDataSource.changePassword(request: request);
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword({
    required ForgetPasswordRequest request,
  }) async {
    try {
      //
      final response = await remoteDataSource.forgetPassword(request: request);
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, SignInResponse>> signIn({required SignInRequest request}) async {
    try {
      final response = await remoteDataSource.signIn(request: request);
      await TokenManager().setToken(token: response.token);
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, SignUpResponse>> signUp({required SignUpRequest request}) async {
    try {
      final response = await remoteDataSource.signUp(request: request);
      await TokenManager().setToken(token: response.token);
      return right(response);
      //
    } on Exception catch (e) {
      debugPrint(e.toString());
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, UpdateUserDataResponse>> updateUserData({
    required UpdateUserDataRequest request,
  }) async {
    try {
      final response = await remoteDataSource.updateUserData(request: request);
      if (response.token != null) {
        await TokenManager().setToken(token: response.token!);
      }
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetUserDataResponse>> getUserData({
    required GetUserDataRequest request,
  }) async {
    try {
      final response = await remoteDataSource.getUserData(request: request);
      await cacheManager().write(
        CacheConstant.userDataDataKey,
        json.encode(response.user.toModel.toJson()),
      );
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, GetUserFavoritesResponse>> getUserFavorites() async {
    try {
      final response = await remoteDataSource.getUserFavorites();
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, AddToUserFavoritesResponse>> addToUserFavorites({
    required AddToUserFavoritesRequest request,
  }) async {
    try {
      final response = await remoteDataSource.addToUserFavorites(request: request);
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, RemoveFromUserFavoritesResponse>> removeFromUserFavorites({
    required RemoveFromUserFavoritesRequest request,
  }) async {
    try {
      final response = await remoteDataSource.removeFromUserFavorites(request: request);
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }

  @override
  Future<Either<Failure, SignOutResponse>> signOut({required SignOutRequest request}) async {
    try {
      final response = await remoteDataSource.signOut(request: request);
      return right(response);
      //
    } on Exception catch (e) {
      return Left(errorToFailure(e));
    }
  }
}
