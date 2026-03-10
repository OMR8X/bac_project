import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/auth/domain/entites/user_data.dart';

part 'user_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserDataModel extends UserData {
  const UserDataModel({
    required super.uuid,
    required super.name,
    required super.governorateId,
    required super.sectionId,
    required super.email,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);

  factory UserDataModel.fromEntity(UserData userData) {
    return UserDataModel(
      uuid: userData.uuid,
      email: userData.email,
      governorateId: userData.governorateId,
      sectionId: userData.sectionId,
      name: userData.name,
    );
  }

  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);
}
