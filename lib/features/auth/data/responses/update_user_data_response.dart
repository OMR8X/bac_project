import 'package:bac_project/core/services/api/responses/api_response.dart';
import 'package:bac_project/features/auth/domain/entites/user_data.dart';
import 'package:bac_project/features/auth/data/models/user_data_model.dart';

class UpdateUserDataResponse {
  final String message;
  final String? token;
  final UserData user;

  UpdateUserDataResponse({required this.message, required this.token, required this.user});

  factory UpdateUserDataResponse.fromResponse(ApiResponse response) {
    return UpdateUserDataResponse(
      message: response.message,
      token: response.getData(key: "token"),
      user: UserDataModel.fromJson(response.getData(key: "user")),
    );
  }
}
