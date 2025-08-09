import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../../../../core/resources/errors/exceptions.dart';
import '../../domain/repositories/tests_repository.dart';
import '../../domain/requests/get_units_request.dart';
import '../../domain/requests/get_lessons_request.dart';
import '../../domain/requests/get_questions_request.dart';
import '../responses/get_units_response.dart';
import '../responses/get_lessons_response.dart';
import '../responses/get_questions_response.dart';
import '../../domain/entities/question.dart';
import '../datasources/tests_remote_data_source.dart';
import '../mappers/unit_mapper.dart';
import '../mappers/lesson_mapper.dart';
import '../mappers/question_mapper.dart';

class TestsRepositoryImpl implements TestsRepository {
  final TestsRemoteDataSource remoteDataSource;

  TestsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, GetUnitsResponse>> getUnits(GetUnitsRequest request) async {
    try {
      final result = await remoteDataSource.getUnits(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      print(e);
      return Left(AnonFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, GetLessonsResponse>> getLessons(GetLessonsRequest request) async {
    try {
      final result = await remoteDataSource.getLessons(request);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (e) {
      print(e);
      return Left(AnonFailure(message: 'An unexpected error occurred: $e'));
    }
  }

  @override
  Future<Either<Failure, GetQuestionsResponse>> getQuestions(GetQuestionsRequest request) async {
    try {
      final result = await remoteDataSource.getQuestions(request);
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
