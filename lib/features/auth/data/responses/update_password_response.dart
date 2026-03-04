import 'package:bac_project/core/services/api/responses/api_response.dart';

class UpdatePasswordResponse {
  final String? message;

  UpdatePasswordResponse({required this.message});

  factory UpdatePasswordResponse.fromResponse(ApiResponse response) {
    return UpdatePasswordResponse(message: response.message);
  }
}
