import 'package:bac_project/features/auth/domain/entites/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel({
    required super.uuid,
    required super.name,
    required super.governorateId,
    required super.sectionId,
    required super.email,
  });

  factory UserDataModel.fromJson(Map json) {
    return UserDataModel(
      uuid: json['uuid'].toString(),
      name: json['name'],
      sectionId: json['section_id'].toString(),
      governorateId: json['governorate_id'].toString(),
      email: json['email'],
    );
  }
  factory UserDataModel.fromEntity(UserData userData) {
    return UserDataModel(
      uuid: userData.uuid,
      email: userData.email,
      governorateId: userData.governorateId,
      sectionId: userData.sectionId,
      name: userData.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "email": email,
      "governorate_id": governorateId,
      "section_id": sectionId,
      "name": name,
    };
  }
}
