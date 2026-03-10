import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/unit.dart';

part 'unit_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UnitModel extends Unit {
  const UnitModel({
    required super.id,
    required super.title,
    required super.subtitle,
    super.lessonsCount,
    super.iconUrl,
    super.createdAt,
    super.updatedAt,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => _$UnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitModelToJson(this);

  @override
  UnitModel copyWith({
    int? id,
    String? title,
    String? subtitle,
    int? lessonsCount,
    String? iconUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UnitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      lessonsCount: lessonsCount ?? this.lessonsCount,
      iconUrl: iconUrl ?? this.iconUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
