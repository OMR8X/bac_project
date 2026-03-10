import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/option.dart';
import '../../domain/entities/question_answer.dart';
import 'package:neuro_app/features/results/domain/entities/answer_evaluation.dart';
import 'package:neuro_app/features/tests/data/models/option_model.dart';
import 'package:neuro_app/features/tests/data/models/question_answer_model.dart';
import 'package:neuro_app/features/results/data/models/answer_evaluation_model.dart';

import 'package:neuro_app/features/tests/data/mappers/option_mapper.dart';
import 'package:neuro_app/features/tests/data/mappers/question_answer_mapper.dart';
import 'package:neuro_app/features/results/data/mappers/answer_evaluation_mapper.dart';
import 'package:neuro_app/core/services/quizz/models/question_type.dart';

part 'question_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class QuestionModel extends Question {
  @override
  @JsonKey(defaultValue: [], fromJson: _optionsFromJson, toJson: _optionsToJson)
  final List<Option> options;

  @override
  // Kept: custom converters for nested lists
  @JsonKey(
    fromJson: _questionAnswersFromJson,
    toJson: _questionAnswersToJson,
  )
  final List<QuestionAnswer> questionAnswers;

  @override
  // Kept: custom converters for nested lists
  @JsonKey(
    fromJson: _answerEvaluationsFromJson,
    toJson: _answerEvaluationsToJson,
  )
  final List<AnswerEvaluation> answerEvaluations;

  const QuestionModel({
    required super.id,
    required super.content,
    required this.options,
    super.type,
    super.unitId,
    required super.lessonId,
    super.imageUrl,
    super.categoryId,
    super.explain,
    this.questionAnswers = const [],
    this.answerEvaluations = const [],
  }) : super(
         options: options,
         questionAnswers: questionAnswers,
         answerEvaluations: answerEvaluations,
       );

  static List<Option> _optionsFromJson(List<dynamic>? json) =>
      json?.map((e) => OptionModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];

  static List<Map<String, dynamic>> _optionsToJson(List<Option> options) =>
      options.map((e) => e.toModel.toJson()).toList();

  static List<QuestionAnswer> _questionAnswersFromJson(List<dynamic>? json) =>
      json?.map((e) => QuestionAnswerModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];

  static List<Map<String, dynamic>>? _questionAnswersToJson(List<QuestionAnswer>? answers) {
    if (answers == null) return null;
    return answers.map((e) => e.toModel.toJson()).toList();
  }

  static List<AnswerEvaluation> _answerEvaluationsFromJson(List<dynamic>? json) =>
      json?.map((e) => AnswerEvaluationModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];

  static List<Map<String, dynamic>>? _answerEvaluationsToJson(List<AnswerEvaluation>? evaluations) {
    if (evaluations == null) return null;
    return evaluations.map((e) => e.toModel.toJson()).toList();
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);
}
