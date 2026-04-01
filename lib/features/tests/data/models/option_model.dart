import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/option.dart';

part 'option_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OptionModel extends Option {
  const OptionModel({
    required super.id,
    required super.questionId,
    required super.content,
    required super.isCorrect,
    super.sortOrder,
    @JsonKey(includeFromJson: false, includeToJson: false) super.typedAnswer,
    super.imageUrl,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) => _$OptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$OptionModelToJson(this);

  Option toEntity() {
    return Option(
      id: id,
      questionId: questionId,
      content: content,
      isCorrect: isCorrect,
      sortOrder: sortOrder,
      typedAnswer: typedAnswer,
      imageUrl: imageUrl,
    );
  }

  @override
  OptionModel copyWith({
    int? id,
    int? questionId,
    String? content,
    bool? isCorrect,
    String? typedAnswer,
    int? sortOrder,
    String? imageUrl,
  }) {
    return OptionModel(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      isCorrect: isCorrect ?? this.isCorrect,
      sortOrder: sortOrder ?? this.sortOrder,
      typedAnswer: typedAnswer ?? this.typedAnswer,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
