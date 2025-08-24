import 'package:bac_project/core/services/api/responses/api_response.dart';

class ForgetPasswordResponse {
  final String message;

  ForgetPasswordResponse({required this.message});

  factory ForgetPasswordResponse.fromResponse(ApiResponse response) {
    return ForgetPasswordResponse(message: response.message);
  }
}
