import 'package:dartz/dartz.dart';

import '../../../../core/resources/errors/failures.dart';
import '../repositories/results_repository.dart';
import '../requests/get_result_leaderboard_request.dart';
import '../../data/responses/get_result_leaderboard_response.dart';

class GetResultLeaderboardUsecase {
  final ResultsRepository repository;

  GetResultLeaderboardUsecase({required this.repository});

  Future<Either<Failure, GetResultLeaderboardResponse>> call(
    GetResultLeaderboardRequest request,
  ) async {
    return await repository.getResultLeaderboard(request);
  }
}
