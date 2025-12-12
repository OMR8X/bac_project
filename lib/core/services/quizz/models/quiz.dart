import 'package:bac_project/core/services/quizz/models/quiz_configuration.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';

class Quiz {
  const Quiz({
    required this.id,
    required this.title,
    // this.description,
    // this.sourceRepositoryId,
    required this.questions,
    required this.configuration,
  });

  final int id;
  final String title;
  final List<Question> questions;
  final QuizConfiguration configuration;

  Quiz copyWith({
    int? id,
    String? title,
    List<Question>? questions,
    QuizConfiguration? configuration,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      questions: questions ?? this.questions,
      configuration: configuration ?? this.configuration,
    );
  }
}
