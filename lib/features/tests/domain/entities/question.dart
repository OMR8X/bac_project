import 'package:bac_project/features/results/domain/entities/answer_evaluation.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import 'package:bac_project/features/tests/domain/entities/question_answer.dart';
import 'package:collection/collection.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    this.explain,
    this.questionAnswers = const [],
    this.answerEvaluations = const [],
  });

  String getImageUrl() {
    if (imageUrl != null) {
      if (imageUrl!.contains("seen")) {
        return imageUrl!;
      }
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
      explain: explain ?? this.explain,
      questionAnswers: questionAnswers ?? this.questionAnswers,
      answerEvaluations: answerEvaluations ?? this.answerEvaluations,
    );
  }

  factory Question.mock() {
    return Question(
      id: 1,
      content: BoneMock.words(8),
      options: [
        Option(id: 1, questionId: 1, content: 'Option A', isCorrect: false),
        Option(id: 2, questionId: 1, content: 'Option B', isCorrect: false),
        Option(id: 3, questionId: 1, content: 'Option C', isCorrect: false),
        Option(id: 4, questionId: 1, content: 'Option D', isCorrect: false),
      ],
      unitId: 1,
      lessonId: 1,
      imageUrl: null,
      categoryId: 1,
      explain: BoneMock.words(5),
      questionAnswers: [],
      answerEvaluations: [],
    );
  }

  @override
  String toString() =>
      'Question(id: $id, content: $content, options: $options, unitId: $unitId, lessonId: $lessonId, imageUrl: $imageUrl, categoryId: $categoryId, explain: $explain, questionAnswers: $questionAnswers, answerEvaluations: $answerEvaluations)';

  static Question empty() {
    return Question(
      id: 0,
      content: '',
      options: [],
      lessonId: 0,
      imageUrl: null,
      categoryId: null,
      explain: null,
      questionAnswers: [],
      answerEvaluations: [],
    );
  }
}
