// ignore_for_file: unnecessary_null_comparison

import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';
import 'package:bac_project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bac_project/features/auth/data/responses/add_to_user_favorites_response.dart';
import 'package:bac_project/features/auth/data/responses/change_password_response.dart';
import 'package:bac_project/features/auth/data/responses/forget_password_response.dart';
import 'package:bac_project/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_project/features/auth/data/responses/get_user_favorites_response.dart';
import 'package:bac_project/features/auth/data/responses/remove_from_user_favorites_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_in_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_out_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_project/features/auth/data/responses/update_user_data_response.dart';
import 'package:bac_project/features/auth/domain/requests/add_to_user_favorites_request.dart';
import 'package:bac_project/features/auth/domain/requests/change_password_request.dart';
import 'package:bac_project/features/auth/domain/requests/forget_password_request.dart';
import 'package:bac_project/features/auth/domain/requests/get_user_data_request.dart';
import 'package:bac_project/features/auth/domain/requests/remove_from_user_favorites_request.dart';
import 'package:bac_project/features/auth/domain/requests/sign_in_request.dart';
import 'package:bac_project/features/auth/domain/requests/sign_out_request.dart';
import 'package:bac_project/features/auth/domain/requests/sign_up_request.dart';
import 'package:bac_project/features/auth/domain/requests/update_user_data_request.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late AuthRemoteDataSourceImplements dataSource;

  setUp(() async {
    ///
    SharedPreferences.setMockInitialValues({});

    ///
    await Supabase.initialize(
      url: SupabaseSettings.url,
      anonKey: SupabaseSettings.anonKey,
    );

    ///
    final apiManager = ApiManager();

    ///
    dataSource = AuthRemoteDataSourceImplements(
      apiManager: apiManager,
      supabaseClient: Supabase.instance.client,
    );
  });

  group('AuthRemoteDataSourceImplements', () {
    group('changePassword', () {
      test('should return ChangePasswordResponse when password is changed successfully', () async {
        // Arrange
        final request = ChangePasswordRequest(code: '123456', password: 'newPassword123');
        // Act & Assert - Method should return expected type
        final response = await dataSource.changePassword(request: request);
        expect(response, isA<ChangePasswordResponse>());
      });
    });

    group('forgetPassword', () {
      test('should return ForgetPasswordResponse when reset email is sent successfully', () async {
        // Arrange
        final request = ForgetPasswordRequest(email: 'test@example.com');
        // Act & Assert - Method should return expected type
        final response = await dataSource.forgetPassword(request: request);
        expect(response, isA<ForgetPasswordResponse>());
      });
    });

    group('signIn', () {
      test('should return SignInResponse when sign in is successful', () async {
        // Arrange
        final request = SignInRequest(
          email: 'test@example.com',
          password: 'password123',
          firebaseToken: 'mock-token',
        );
        // Act & Assert - Method should return expected type
        final response = await dataSource.signIn(request: request);
        expect(response, isA<SignInResponse>());
      });
    });

    group('signUp', () {
      test('should return SignUpResponse when sign up is successful', () async {
        // Arrange
        final request = SignUpRequest(
          email: 'test@example.com',
          password: 'password123',
          name: 'Test User',
          sectionId: 1,
          governorateId: 1,
          firebaseToken: 'mock-token',
        );
        // Act & Assert - Method should return expected type
        final response = await dataSource.signUp(request: request);
        expect(response, isA<SignUpResponse>());
      });
    });

    group('getUserData', () {
      test('should return GetUserDataResponse when user is authenticated', () async {
        // Arrange
        final request = GetUserDataRequest();
        // Act & Assert - Method should return expected type
        final response = await dataSource.getUserData(request: request);
        expect(response, isA<GetUserDataResponse>());
      });
    });

    group('getUserFavorites', () {
      test('should return GetUserFavoritesResponse', () async {
        // Act & Assert - Method should return expected type
        final response = await dataSource.getUserFavorites();
        expect(response, isA<GetUserFavoritesResponse>());
      });
    });

    group('addToUserFavorites', () {
      test('should return AddToUserFavoritesResponse when item is added successfully', () async {
        // Arrange
        final request = AddToUserFavoritesRequest(fileId: '1');
        // Act & Assert - Method should return expected type
        final response = await dataSource.addToUserFavorites(request: request);
        expect(response, isA<AddToUserFavoritesResponse>());
      });
    });

    group('removeFromUserFavorites', () {
      test(
        'should return RemoveFromUserFavoritesResponse when item is removed successfully',
        () async {
          // Arrange
          final request = RemoveFromUserFavoritesRequest(fileId: '1');
          // Act & Assert - Method should return expected type
          final response = await dataSource.removeFromUserFavorites(request: request);
          expect(response, isA<RemoveFromUserFavoritesResponse>());
        },
      );
    });

    group('signOut', () {
      test('should return SignOutResponse when sign out is successful', () async {
        // Arrange
        final request = SignOutRequest();
        // Act & Assert - Method should return expected type
        final response = await dataSource.signOut(request: request);
        expect(response, isA<SignOutResponse>());
      });
    });

    group('updateUserData', () {
      test('should return UpdateUserDataResponse when user data is updated successfully', () async {
        // Arrange
        final request = UpdateUserDataRequest(
          email: 'newemail@example.com',
          password: 'newpassword123',
          name: 'Updated Name',
          sectionId: 2,
          governorateId: 2,
        );
        // Act & Assert - Method should return expected type
        final response = await dataSource.updateUserData(request: request);
        expect(response, isA<UpdateUserDataResponse>());
      });
    });
  });
}
