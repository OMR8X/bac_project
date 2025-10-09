import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../requests/get_units_request.dart';
import '../requests/get_lessons_request.dart';
import '../requests/get_questions_request.dart';
import '../requests/get_questions_by_ids_request.dart';
import '../requests/get_test_options_request.dart';
import '../../data/responses/get_units_response.dart';
import '../../data/responses/get_lessons_response.dart';
import '../../data/responses/get_questions_response.dart';
import '../../data/responses/get_test_options_response.dart';

abstract class TestsRepository {
  Future<Either<Failure, GetUnitsResponse>> getUnits(GetUnitsRequest request);
  Future<Either<Failure, GetLessonsResponse>> getLessons(GetLessonsRequest request);
  Future<Either<Failure, GetQuestionsResponse>> getQuestions(GetQuestionsRequest request);
  Future<Either<Failure, GetQuestionsResponse>> getQuestionsByIds(GetQuestionsByIdsRequest request);
  Future<Either<Failure, GetTestOptionsResponse>> getTestOptions(GetTestOptionsRequest request);
}
