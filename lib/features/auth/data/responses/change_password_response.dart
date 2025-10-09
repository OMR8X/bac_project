import 'package:bac_project/core/services/api/responses/api_response.dart';

class ChangePasswordResponse {
  final String? message;

  ChangePasswordResponse({required this.message});

  factory ChangePasswordResponse.fromResponse(ApiResponse response) {
    return ChangePasswordResponse(message: response.message);
  }
}
