import 'package:neuro_app/features/auth/data/models/user_data_model.dart';
import 'package:neuro_app/features/auth/domain/entites/user_data.dart';
import 'package:neuro_app/core/services/api/responses/api_response.dart';

class SignUpResponse {
  final String? message;
  final String token;
  final UserData user;

  SignUpResponse({required this.message, required this.token, required this.user});

  factory SignUpResponse.fromResponse(ApiResponse response) {
    return SignUpResponse(
      message: response.message,
      token: response.data["token"],
      user: UserDataModel.fromJson(response.data["user"]),
    );
  }
}
