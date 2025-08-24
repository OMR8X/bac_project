import '../../../settings/domain/entities/governorate.dart';
import '../models/governorate_model.dart';

extension GovernorateMapper on Governorate {
  GovernorateModel get toModel {
    return GovernorateModel(
      id: id,
      name: name,
    );
  }
}

extension GovernorateModelMapper on GovernorateModel {
  Governorate get toEntity {
    return Governorate(
      id: id,
      name: name,
    );
  }
}
