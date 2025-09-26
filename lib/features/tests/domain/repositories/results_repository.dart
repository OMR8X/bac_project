import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../data/responses/add_result_response.dart';
import '../../data/responses/get_results_response.dart';
import '../../data/responses/get_result_response.dart';
import '../../data/responses/get_result_leaderboard_response.dart';
import '../../data/responses/get_result_questions_details_response.dart';
import '../requests/add_result_request.dart';
import '../requests/get_my_results_request.dart';
import '../requests/get_result_request.dart';
import '../requests/get_result_leaderboard_request.dart';
import '../requests/get_result_questions_details_request.dart';

abstract class ResultsRepository {
  Future<Either<Failure, AddResultResponse>> addResult(AddResultRequest request);
  Future<Either<Failure, GetResultsResponse>> getMyResults(GetMyResultsRequest request);
  Future<Either<Failure, GetResultResponse>> getResult(GetResultRequest request);
  Future<Either<Failure, GetResultLeaderboardResponse>> getResultLeaderboard(
    GetResultLeaderboardRequest request,
  );
  Future<Either<Failure, GetResultQuestionsDetailsResponse>> getResultQuestionsDetails(
    GetResultQuestionsDetailsRequest request,
  );
}
