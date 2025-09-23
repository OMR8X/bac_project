import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/tests_repository.dart';
import '../requests/get_answer_evaluations_request.dart';
import '../../data/responses/get_answer_evaluations_response.dart';

class GetAnswerEvaluationsUsecase {
  final TestsRepository repository;

  GetAnswerEvaluationsUsecase({required this.repository});

  Future<Either<Failure, GetAnswerEvaluationsResponse>> call(
    GetAnswerEvaluationsRequest request,
  ) async {
    return await repository.getAnswerEvaluations(request);
  }
}
