import '../../domain/requests/add_result_request.dart';
import '../../domain/requests/get_my_results_request.dart';
import '../responses/add_result_response.dart';
import '../responses/get_results_response.dart';

abstract class ResultsRemoteDataSource {
  Future<AddResultResponse> addResult(AddResultRequest request);
  Future<GetResultsResponse> getMyResults(GetMyResultsRequest request);
}
