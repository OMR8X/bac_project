class ForgetPasswordRequest {
  final String email;

  ForgetPasswordRequest({required this.email});

  Map<String, dynamic> toBody() {
    return {
      "email": email,
    };
  }
}
