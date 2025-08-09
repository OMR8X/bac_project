import 'package:bac_project/features/tests/data/models/question_model.dart';

import 'fixtures/sample_questions_generator.dart';

void main() {
  final List<QuestionModel> questions = SampleQuestionsGenerator.generateSampleQuestions(1);
  for (var question in questions) {
    print(question.toJson());
  }
}
