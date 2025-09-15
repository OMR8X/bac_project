import 'package:bac_project/features/settings/domain/entities/section.dart';

class SectionModel extends Section {
  const SectionModel({required super.id, required super.title});

  //
  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
