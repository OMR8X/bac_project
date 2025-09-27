import 'package:bac_project/core/resources/errors/error_mapper.dart';

import '../../domain/entities/question.dart';
import '../models/question_model.dart';

class GetResultQuestionsDetailsResponse {
  final List<Question> resultQuestions;

  const GetResultQuestionsDetailsResponse({required this.resultQuestions});

  factory GetResultQuestionsDetailsResponse.fromJson(Map<String, dynamic> json) {
    try {
      return GetResultQuestionsDetailsResponse(
        resultQuestions:
            (json['questions'] as List<dynamic>?)
                ?.map((question) => QuestionModel.fromJson(question as Map<String, dynamic>))
                .toList() ??
            [],
      );
    } catch (e) {
      throw errorToFailure(e);
    }
  }

  @override
  String toString() => 'GetResultQuestionsDetailsResponse(resultQuestions: $resultQuestions)';
}
