import 'package:bac_project/features/auth/data/models/section_model.dart';
import 'package:bac_project/features/settings/domain/entities/section.dart';

extension SectionMapper on Section {
  SectionModel get toModel {
    return SectionModel(id: id, name: name);
  }
}

extension SectionModelMapper on SectionModel {
  Section get toEntity {
    return Section(id: id, name: name);
  }
}
