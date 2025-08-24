import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../data/responses/add_result_response.dart';
import '../../data/responses/get_results_response.dart';
import '../requests/add_result_request.dart';
import '../requests/get_my_results_request.dart';

abstract class ResultsRepository {
  Future<Either<Failure, AddResultResponse>> addResult(AddResultRequest request);
  Future<Either<Failure, GetResultsResponse>> getMyResults(GetMyResultsRequest request);
}
