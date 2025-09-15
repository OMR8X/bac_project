class SignUpRequest {
  final String name;
  final String email;
  final int sectionId;
  final int governorateId;
  final String? firebaseToken;

  final String password;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.sectionId,
    required this.governorateId,
    required this.firebaseToken,
    required this.password,
  });

  Map<String, dynamic> toBody() {
    return {
      "name": name,
      "email": email,
      "section_id": sectionId,
      "governorate_id": governorateId,
      "firebase_token": firebaseToken,
      "password": password,
    };
  }
}
