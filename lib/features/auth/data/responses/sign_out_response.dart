import 'package:bac_project/core/services/api/responses/api_response.dart';

class SignOutResponse {
  final String message;

  SignOutResponse({required this.message});

  factory SignOutResponse.fromResponse(ApiResponse response) {
    return SignOutResponse(
      message: response.message,
    );
  }
}
