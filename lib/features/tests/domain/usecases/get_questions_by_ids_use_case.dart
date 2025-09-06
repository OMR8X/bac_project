import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/tests_repository.dart';
import '../requests/get_questions_by_ids_request.dart';
import '../../data/responses/get_questions_response.dart';

class GetQuestionsByIdsUsecase {
  final TestsRepository repository;

  GetQuestionsByIdsUsecase({required this.repository});

  Future<Either<Failure, GetQuestionsResponse>> call(GetQuestionsByIdsRequest request) async {
    return await repository.getQuestionsByIds(request);
  }
}
