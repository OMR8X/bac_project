class GetUserDataRequest {
  final String? userId;

  GetUserDataRequest({this.userId});

  Map<String, dynamic> toBody() {
    return {
      "user_id": userId,
    };
  }
}
