import 'package:json_annotation/json_annotation.dart';
import 'package:neuro_app/features/tests/data/mappers/question_answer_mapper.dart';
import 'package:neuro_app/features/tests/data/models/question_answer_model.dart';
import 'package:neuro_app/features/tests/domain/entities/question_answer.dart';
import 'package:neuro_app/features/results/domain/entities/result_test_mode.dart';

import '../../domain/entities/result.dart';

part 'result_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ResultModel extends Result {
  @override
  // Kept: custom enum mapping from boolean field is_test_mode
  @JsonKey(name: 'is_test_mode', fromJson: _resultTestModeFromJson, toJson: _resultTestModeToJson)
  final ResultTestMode? resultTestMode;

  @override
  // Kept: custom object list mappings
  @JsonKey(
    defaultValue: [],
    fromJson: _questionAnswersFromJson,
    toJson: _questionAnswersToJson,
  )
  final List<QuestionAnswer> questionAnswers;

  const ResultModel({
    required super.id,
    required super.userId,
    super.lessonId,
    super.lessonTitle,
    // Kept: DB column name is user_rank but Dart field is resultOrder
    @JsonKey(name: 'user_rank') super.resultOrder,
    required super.totalQuestions,
    required super.correctAnswers,
    required super.wrongAnswers,
    required super.score,
    required super.durationSeconds,
    this.resultTestMode,
    required this.questionAnswers,
    required super.createdAt,
    required super.updatedAt,
  }) : super(
         resultTestMode: resultTestMode,
         questionAnswers: questionAnswers,
       );

  static ResultTestMode? _resultTestModeFromJson(bool? isTestMode) =>
      isTestMode == null ? null : (isTestMode ? ResultTestMode.testing : ResultTestMode.exploring);

  static bool? _resultTestModeToJson(ResultTestMode? mode) =>
      mode != null ? mode == ResultTestMode.testing : null;

  static List<QuestionAnswer> _questionAnswersFromJson(List<dynamic>? jsonItems) {
    if (jsonItems == null) return [];
    return jsonItems.map((a) => QuestionAnswerModel.fromJson(a as Map<String, dynamic>)).toList();
  }

  static List<Map<String, dynamic>> _questionAnswersToJson(List<QuestionAnswer> items) {
    return items.map((a) => a.toModel.toJson()).toList();
  }

  factory ResultModel.fromJson(Map<String, dynamic> json) => _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);

  @override
  ResultModel copyWith({
    int? id,
    String? userId,
    int? lessonId,
    String? lessonTitle,
    int? resultOrder,
    int? totalQuestions,
    int? correctAnswers,
    int? wrongAnswers,
    double? score,
    int? durationSeconds,
    ResultTestMode? resultTestMode,
    List<QuestionAnswer>? questionAnswers,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ResultModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      lessonId: lessonId ?? this.lessonId,
      lessonTitle: lessonTitle ?? this.lessonTitle,
      resultOrder: resultOrder ?? this.resultOrder,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      score: score ?? this.score,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      resultTestMode: resultTestMode ?? this.resultTestMode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
