class SignInRequest {
  //
  final String email;
  final String? firebaseToken;
  final String password;

  SignInRequest({
    required this.email,
    required this.firebaseToken,
    required this.password,
  });

  Map<String, dynamic> toBody() {
    return {
      "email": email,
      "firebase_token": firebaseToken,
      "password": password,
    };
  }
}
