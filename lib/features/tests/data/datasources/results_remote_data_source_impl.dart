import 'package:bac_project/core/services/api/api_constants.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/features/tests/data/responses/add_result_response.dart';
import 'package:bac_project/features/tests/data/responses/get_results_response.dart';

import '../../domain/requests/add_result_request.dart';
import '../../domain/requests/get_my_results_request.dart';
import 'results_remote_data_source.dart';

class ResultsRemoteDataSourceImpl implements ResultsRemoteDataSource {
  final ApiManager apiManager;

  ResultsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<AddResultResponse> addResult(AddResultRequest request) async {
    final query = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.addUserResultFunctionEndpoint),
      body: request.toJsonBody(),
    );

    return AddResultResponse.fromJson((query.data as Map<String, dynamic>));
  }

  @override
  Future<GetResultsResponse> getMyResults(GetMyResultsRequest request) async {
    final query = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getUserResultsFunctionEndpoint),
      body: request.toJsonBody(),
    );

    return GetResultsResponse.fromJson(query.data as Map<String, dynamic>);
  }
}
