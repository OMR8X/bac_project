import 'package:bac_project/core/injector/app_injection.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/tokens/tokens_manager.dart';
import 'package:bac_project/features/auth/data/models/user_data_model.dart';
import 'package:bac_project/features/auth/data/responses/change_password_response.dart';
import 'package:bac_project/features/auth/data/responses/forget_password_response.dart';
import 'package:bac_project/features/auth/data/responses/get_user_data_response.dart';
import 'package:bac_project/features/auth/data/responses/remove_from_user_favorites_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_in_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_out_response.dart';
import 'package:bac_project/features/auth/data/responses/sign_up_response.dart';
import 'package:bac_project/features/auth/data/responses/update_user_data_response.dart';
import 'package:bac_project/features/auth/domain/requests/add_to_user_favorites_request.dart';
import 'package:bac_project/features/auth/domain/requests/change_password_request.dart';
import 'package:bac_project/features/auth/domain/requests/get_user_data_request.dart';
import 'package:bac_project/features/auth/domain/requests/remove_from_user_favorites_request.dart';
import 'package:bac_project/features/auth/domain/requests/sign_out_request.dart';
import 'package:bac_project/features/auth/domain/requests/sign_in_request.dart';
import 'package:bac_project/features/auth/domain/requests/sign_up_request.dart';
import 'package:bac_project/features/auth/domain/requests/update_user_data_request.dart';
import 'package:bac_project/features/auth/data/responses/add_to_user_favorites_response.dart';
import 'package:bac_project/features/auth/data/responses/get_user_favorites_response.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/requests/forget_password_request.dart';

abstract class AuthRemoteDataSource {
  // change user password
  Future<ChangePasswordResponse> changePassword({required ChangePasswordRequest request});
  // send code to user via email to reset password.
  Future<ForgetPasswordResponse> forgetPassword({required ForgetPasswordRequest request});
  // signing in
  Future<SignInResponse> signIn({required SignInRequest request});
  // signing up
  Future<SignUpResponse> signUp({required SignUpRequest request});
  // update user data
  Future<UpdateUserDataResponse> updateUserData({required UpdateUserDataRequest request});
  // update user data
  Future<SignOutResponse> signOut({required SignOutRequest request});
  // update user data
  Future<GetUserDataResponse> getUserData({required GetUserDataRequest request});
  // update user data
  Future<AddToUserFavoritesResponse> addToUserFavorites({
    required AddToUserFavoritesRequest request,
  });
  // update user data
  Future<RemoveFromUserFavoritesResponse> removeFromUserFavorites({
    required RemoveFromUserFavoritesRequest request,
  });
  // update user data
  Future<GetUserFavoritesResponse> getUserFavorites();
}

class AuthRemoteDataSourceImplements implements AuthRemoteDataSource {
  final ApiManager apiManager;

  AuthRemoteDataSourceImplements({required this.apiManager});

  @override
  Future<ChangePasswordResponse> changePassword({required ChangePasswordRequest request}) async {
    // Supabase: update user password
    final supabase = Supabase.instance.client;
    await supabase.auth.updateUser(UserAttributes(password: request.password));
    return ChangePasswordResponse(message: 'تم تغيير كلمة المرور');
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword({required ForgetPasswordRequest request}) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.resetPasswordForEmail(request.email);
    return ForgetPasswordResponse(message: 'تم إرسال رابط إعادة التعيين إلى بريدك');
  }

  @override
  Future<SignInResponse> signIn({required SignInRequest request}) async {
    final supabase = Supabase.instance.client;
    final result = await supabase.auth.signInWithPassword(
      email: request.email,
      password: request.password,
    );
    final accessToken = result.session?.accessToken;
    final user = result.user;
    if (user == null) {
      throw AuthException('فشل تسجيل الدخول');
    }
    return SignInResponse(
      message: 'تم تسجيل الدخول',
      token: accessToken ?? '',
      user: UserDataModel(
        uuid: user.id,
        name: user.userMetadata?['name'] ?? '',
        governorateId: (user.userMetadata?['governorate_id'] ?? '').toString(),
        sectionId: (user.userMetadata?['section_id'] ?? '').toString(),
        email: user.email ?? '',
      ),
    );
  }

  @override
  Future<SignUpResponse> signUp({required SignUpRequest request}) async {
    final supabase = Supabase.instance.client;
    final result = await supabase.auth.signUp(
      email: request.email,
      password: request.password,
      data: {
        'name': request.name,
        'section_id': request.sectionId,
        'governorate_id': request.governorateId,
        'account_type': 'student',
      },
    );
    final accessToken = result.session?.accessToken;
    final user = result.user;
    if (user == null) {
      throw AuthException('فشل إنشاء الحساب');
    }
    return SignUpResponse(
      message: 'تم إنشاء الحساب',
      token: accessToken ?? '',
      user: UserDataModel(
        uuid: user.id,
        name: user.userMetadata?['name'] ?? '',
        governorateId: (user.userMetadata?['governorate_id'] ?? '').toString(),
        sectionId: (user.userMetadata?['section_id'] ?? '').toString(),
        email: user.email ?? '',
      ),
    );
  }

  @override
  Future<GetUserDataResponse> getUserData({required GetUserDataRequest request}) async {
    final supabase = Supabase.instance.client;
    final currentUser = supabase.auth.currentUser;
    await supabase.auth.refreshSession();

    if (currentUser == null) {
      throw AuthException('غير مسجل الدخول');
    }
    final user = currentUser;

    return GetUserDataResponse(
      message: 'تم الجلب',
      user: UserDataModel(
        uuid: user.id,
        name: user.userMetadata?['name'] ?? '',
        governorateId: (user.userMetadata?['governorate_id'] ?? '').toString(),
        sectionId: (user.userMetadata?['section_id'] ?? '').toString(),
        email: user.email ?? '',
      ),
    );
  }

  @override
  Future<GetUserFavoritesResponse> getUserFavorites() async {
    // Not implemented with Supabase in this app yet
    return GetUserFavoritesResponse(message: 'OK', favorites: []);
  }

  @override
  Future<AddToUserFavoritesResponse> addToUserFavorites({
    required AddToUserFavoritesRequest request,
  }) async {
    return AddToUserFavoritesResponse(message: 'OK', favorites: []);
  }

  @override
  Future<RemoveFromUserFavoritesResponse> removeFromUserFavorites({
    required RemoveFromUserFavoritesRequest request,
  }) async {
    return RemoveFromUserFavoritesResponse(message: 'OK', favorites: []);
  }

  @override
  Future<SignOutResponse> signOut({required SignOutRequest request}) async {
    final supabase = Supabase.instance.client;
    await supabase.auth.signOut();
    await TokenManager().deleteToken();
    return SignOutResponse(message: 'تم تسجيل الخروج');
  }

  @override
  Future<UpdateUserDataResponse> updateUserData({required UpdateUserDataRequest request}) async {
    print("email: ${request.email}");
    final supabase = Supabase.instance.client;
    final attributes = UserAttributes(
      email: request.email,
      password: request.password,
      data: request.toBody(old: 
      supabase.auth.currentUser?.userMetadata),
    );
    final res = await supabase.auth.updateUser(attributes);
    final user = res.user;
    final accessToken = supabase.auth.currentSession?.accessToken;

    return UpdateUserDataResponse(
      message: 'تم تحديث البيانات',
      token: accessToken ?? '',
      user: UserDataModel(
        uuid: user?.id ?? '',
        name: user?.userMetadata?['name'] ?? '',
        governorateId: (user?.userMetadata?['governorate_id'] ?? '').toString(),
        sectionId: (user?.userMetadata?['section_id'] ?? '').toString(),
        email: user?.email ?? '',
      ),
    );
  }
}
