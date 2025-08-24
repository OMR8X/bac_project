import '../../../../core/services/api/responses/api_response.dart';

class SendNotificationResponse {
  final String message;

  SendNotificationResponse({required this.message});

  //
  factory SendNotificationResponse.fromApiResponse({
    required ApiResponse response,
  }) {
    return SendNotificationResponse(
      message: response.message,
    );
  }
}
