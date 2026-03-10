import 'package:json_annotation/json_annotation.dart';
import '../../../settings/domain/entities/governorate.dart';

part 'governorate_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GovernorateModel extends Governorate {
  const GovernorateModel({required super.id, required super.title});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) => _$GovernorateModelFromJson(json);

  Map<String, dynamic> toJson() => _$GovernorateModelToJson(this);
}
