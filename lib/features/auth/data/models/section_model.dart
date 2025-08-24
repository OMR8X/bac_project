import 'package:bac_project/features/settings/domain/entities/section.dart';

class SectionModel extends Section {
  const SectionModel({required super.id, required super.name});

  //
  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(id: json['id'].toString(), name: json['name'].toString());
  }

  //
  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
