import 'dart:convert';

import 'package:bac_project/core/services/api/responses/api_response.dart';
import 'package:bac_project/features/auth/domain/entites/user_data.dart';
import 'package:bac_project/features/auth/data/models/user_data_model.dart';

class GetUserDataResponse {
  final String message;
  final UserData user;

  GetUserDataResponse({required this.message, required this.user});

  factory GetUserDataResponse.fromResponse(ApiResponse response) {
    return GetUserDataResponse(
      message: response.message,
      user: UserDataModel.fromJson(response.getData(key: "user")),
    );
  }
  factory GetUserDataResponse.fromCache(dynamic data) {
    return GetUserDataResponse(message: "", user: UserDataModel.fromJson(json.decode(data)));
  }
}
