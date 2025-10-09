import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/results_repository.dart';
import '../requests/get_result_questions_details_request.dart';
import '../../data/responses/get_result_questions_details_response.dart';

class GetResultQuestionsDetailsUsecase {
  final ResultsRepository repository;

  GetResultQuestionsDetailsUsecase({required this.repository});

  Future<Either<Failure, GetResultQuestionsDetailsResponse>> call(
    GetResultQuestionsDetailsRequest request,
  ) async {
    return await repository.getResultQuestionsDetails(request);
  }
}
