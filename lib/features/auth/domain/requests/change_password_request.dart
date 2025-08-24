class ChangePasswordRequest {
  final String code;
  final String password;

  ChangePasswordRequest({
    required this.code,
    required this.password,
  });

  Map<String, dynamic> toBody() {
    return {
      "code": code,
      "password": password,
    };
  }
}
