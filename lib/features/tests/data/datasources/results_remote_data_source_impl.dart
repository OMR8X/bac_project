import 'package:bac_project/core/services/api/api_constants.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/responses/api_response.dart';
import 'package:bac_project/features/tests/data/responses/add_result_response.dart';
import 'package:bac_project/features/tests/data/responses/get_results_response.dart';
import 'package:bac_project/features/tests/data/responses/get_result_response.dart';
import 'package:bac_project/features/tests/data/responses/get_result_leaderboard_response.dart';

import '../../domain/requests/add_result_request.dart';
import '../../domain/requests/get_my_results_request.dart';
import '../../domain/requests/get_result_request.dart';
import '../../domain/requests/get_result_leaderboard_request.dart';
import 'results_remote_data_source.dart';

class ResultsRemoteDataSourceImpl implements ResultsRemoteDataSource {
  final ApiManager apiManager;

  ResultsRemoteDataSourceImpl({required this.apiManager});

  @override
  Future<AddResultResponse> addResult(AddResultRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.edge(SupabaseEndpoints.addUserResultEdgeFunctionEndpoint),
      body: request.toJsonBody(),
    );

    ///
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);

    ///
    apiResponse.throwErrorIfExists();

    return AddResultResponse.fromJson((apiResponse.data));
  }

  @override
  Future<GetResultsResponse> getMyResults(GetMyResultsRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getUserResultsFunctionEndpoint),
      body: request.toJsonBody(),
    );

    ///
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);

    ///
    apiResponse.throwErrorIfExists();

    return GetResultsResponse.fromJson(apiResponse.data);
  }

  @override
  Future<GetResultResponse> getResult(GetResultRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getUserResultByIdFunctionEndpoint),
      body: request.toJsonBody(),
    );

    ///
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);

    ///
    apiResponse.throwErrorIfExists();

    return GetResultResponse.fromJson(apiResponse.data);
  }

  @override
  Future<GetResultLeaderboardResponse> getResultLeaderboard(
    GetResultLeaderboardRequest request,
  ) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getResultLeaderboardFunctionEndpoint),
      body: request.toJsonBody(),
    );

    ///
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);

    ///
    apiResponse.throwErrorIfExists();

    return GetResultLeaderboardResponse.fromJson(apiResponse.data);
  }
}
