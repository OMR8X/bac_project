import 'package:neuro_app/features/auth/data/models/section_model.dart';
import 'package:neuro_app/features/settings/domain/entities/section.dart';

extension SectionMapper on Section {
  SectionModel get toModel {
    return SectionModel(id: id, title: title);
  }
}

extension SectionModelMapper on SectionModel {
  Section get toEntity {
    return Section(id: id, title: title);
  }
}
