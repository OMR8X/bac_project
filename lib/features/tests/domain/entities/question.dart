import 'package:bac_project/features/tests/domain/entities/answer_evaluation.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:collection/collection.dart';

class Question {
  //
  final int id;
  final String content;
  //
  final int? unitId;
  final int lessonId;
  final String? imageUrl;
  //
  final List<Option> options;

  final int? categoryId;

  final bool? isMCQ;

  final String? explain;

  final List<QuestionAnswer> questionAnswers;
  final List<AnswerEvaluation> answerEvaluations;

  const Question({
    required this.id,
    required this.content,
    required this.options,
    this.unitId,
    required this.lessonId,
    this.imageUrl,
    this.categoryId,
    this.isMCQ,
    this.explain,
    this.questionAnswers = const [],
    this.answerEvaluations = const [],
  });

  String getImageUrl() {
    if (imageUrl != null) {
      return 'https://hvccufhuqizyposxasck.supabase.co/storage/v1/object/public/$imageUrl';
    }
    return '';
  }

  bool? trueAnswer(int answerId) {
    return options.firstWhereOrNull((option) => option.isCorrect ?? false)?.id == answerId;
  }

  Question copyWith({
    int? id,
    String? content,
    List<Option>? options,
    int? unitId,
    int? lessonId,
    String? imageUrl,
    int? categoryId,
    bool? isMCQ,
    String? explain,
    List<QuestionAnswer>? questionAnswers,
    List<AnswerEvaluation>? answerEvaluations,
  }) {
    return Question(
      id: id ?? this.id,
      content: content ?? this.content,
      options: options ?? this.options,
      unitId: unitId ?? this.unitId,
      lessonId: lessonId ?? this.lessonId,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      isMCQ: isMCQ ?? this.isMCQ,
      explain: explain ?? this.explain,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      answerEvaluations: answerEvaluations ?? this.answerEvaluations,
    );
  }

  @override
  String toString() =>
      'Question(id: $id, content: $content, options: $options, unitId: $unitId, lessonId: $lessonId, imageUrl: $imageUrl, categoryId: $categoryId, isMCQ: $isMCQ, explain: $explain, questionAnswers: $questionAnswers, answerEvaluations: $answerEvaluations)';

  static Question empty() {
    return Question(
      id: 0,
      content: '',
      options: [],
      lessonId: 0,
      imageUrl: null,
      categoryId: null,
      isMCQ: null,
      explain: null,
      questionAnswers: [],
      answerEvaluations: [],
    );
  }
}
