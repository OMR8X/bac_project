class UpdateUserDataRequest {
  final String? name;
  final String? email;
  final String? sectionId;
  final String? governorateId;
  final String? password;

  UpdateUserDataRequest({this.name, this.email, this.sectionId, this.governorateId, this.password});

  ///
  Map<String, dynamic> toBody({Map<String, dynamic>? old}) {
    return {
      "name": name ?? old?['name'],
      "email": email ?? old?['email'],
      "section_id": sectionId ?? old?['section_id'],
      "governorate_id": governorateId ?? old?['governorate_id'],
      "password": password ?? old?['password'],
    };
  }
}
