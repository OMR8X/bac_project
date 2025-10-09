import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/results_repository.dart';
import '../requests/get_my_results_request.dart';
import '../../data/responses/get_results_response.dart';

class GetMyResultsUsecase {
  final ResultsRepository repository;

  GetMyResultsUsecase({required this.repository});

  Future<Either<Failure, GetResultsResponse>> call(GetMyResultsRequest request) async {
    return await repository.getMyResults(request);
  }
}
