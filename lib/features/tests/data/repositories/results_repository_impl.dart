import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../core/resources/errors/exceptions.dart';
import '../../domain/repositories/results_repository.dart';
import '../../domain/requests/add_result_request.dart';
import '../../domain/requests/get_my_results_request.dart';
import '../responses/add_result_response.dart';
import '../responses/get_results_response.dart';
import '../datasources/results_remote_data_source.dart';

class ResultsRepositoryImpl implements ResultsRepository {
  final ResultsRemoteDataSource remoteDataSource;

  ResultsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AddResultResponse>> addResult(AddResultRequest request) async {
    try {
      final result = await remoteDataSource.addResult(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(AnonFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, GetResultsResponse>> getMyResults(GetMyResultsRequest request) async {
    try {
      final result = await remoteDataSource.getMyResults(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      return Left(AnonFailure(message: 'An unexpected error occurred: $e'));
    }
  }
}
