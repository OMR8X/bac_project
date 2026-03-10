import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/settings/domain/entities/section.dart';

part 'section_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SectionModel extends Section {
  const SectionModel({required super.id, required super.title});

  factory SectionModel.fromJson(Map<String, dynamic> json) => _$SectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionModelToJson(this);
}
