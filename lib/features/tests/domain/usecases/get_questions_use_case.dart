import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/tests_repository.dart';
import '../requests/get_questions_request.dart';
import '../../data/responses/get_questions_response.dart';

class GetQuestionsUsecase {
  final TestsRepository repository;

  GetQuestionsUsecase({required this.repository});

  Future<Either<Failure, GetQuestionsResponse>> call(GetQuestionsRequest request) async {
    return await repository.getQuestions(request);
  }
}
