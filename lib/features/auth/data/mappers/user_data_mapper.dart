import 'package:neuro_app/features/auth/domain/entites/user_data.dart';
import 'package:neuro_app/features/auth/data/models/user_data_model.dart';

extension UserDataMapper on UserData {
  UserDataModel get toModel {
    return UserDataModel(
      uuid: uuid,
      name: name,
      sectionId: sectionId,
      governorateId: governorateId,
      email: email,
    );
  }
}

extension UserDataModelMapper on UserDataModel {
  UserData get toEntity {
    return UserData(
      uuid: uuid,
      name: name,
      sectionId: sectionId,
      governorateId: governorateId,
      email: email,
    );
  }
}
