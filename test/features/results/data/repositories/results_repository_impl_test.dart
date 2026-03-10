import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:neuro_app/features/results/data/repositories/results_repository_impl.dart';
import 'package:neuro_app/core/resources/errors/failures.dart';
import 'package:neuro_app/core/resources/errors/exceptions.dart';

import '../../helpers/results_test_fixtures.dart';
import '../../helpers/results_test_mocks.mocks.dart';

void main() {
  late ResultsRepositoryImpl repository;
  late MockResultsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockResultsRemoteDataSource();
    repository = ResultsRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('addResult', () {
    final tRequest = ResultsTestFixtures.tAddResultRequest;
    final tResponse = ResultsTestFixtures.tAddResultResponse;

    test('should return AddResultResponse when remote data source call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.addResult(tRequest)).thenAnswer((_) async => tResponse);

      // Act
      final result = await repository.addResult(tRequest);

      // Assert
      expect(result, Right(tResponse));
      verify(mockRemoteDataSource.addResult(tRequest));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return ServerFailure when remote data source throws a ServerException', () async {
      // Arrange
      when(
        mockRemoteDataSource.addResult(tRequest),
      ).thenThrow(const ServerException(message: 'Server Error'));

      // Act
      final result = await repository.addResult(tRequest);

      // Assert
      expect(result, const Left(ServerFailure(message: 'Server Error')));
      verify(mockRemoteDataSource.addResult(tRequest));
    });
  });

  group('getMyResults', () {
    const tRequest = ResultsTestFixtures.tGetMyResultsRequest;
    final tResponse = ResultsTestFixtures.tGetResultsResponse;

    test('should return GetResultsResponse when remote call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getMyResults(tRequest)).thenAnswer((_) async => tResponse);

      // Act
      final result = await repository.getMyResults(tRequest);

      // Assert
      expect(result, Right(tResponse));
      verify(mockRemoteDataSource.getMyResults(tRequest));
    });

    test('should return ServerFailure when remote call throws ServerException', () async {
      // Arrange
      when(
        mockRemoteDataSource.getMyResults(tRequest),
      ).thenThrow(const ServerException(message: 'Error'));

      // Act
      final result = await repository.getMyResults(tRequest);

      // Assert
      expect(result, const Left(ServerFailure(message: 'Error')));
    });
  });

  group('getResult', () {
    const tRequest = ResultsTestFixtures.tGetResultRequest;
    final tResponse = ResultsTestFixtures.tGetResultResponse;

    test('should return GetResultResponse when remote call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getResult(tRequest)).thenAnswer((_) async => tResponse);

      // Act
      final result = await repository.getResult(tRequest);

      // Assert
      expect(result, Right(tResponse));
      verify(mockRemoteDataSource.getResult(tRequest));
    });

    test('should return ServerFailure when remote call throws an Exception', () async {
      // Arrange
      // errorToFailure handles Exceptions and maps them to UnknownFailure
      when(mockRemoteDataSource.getResult(tRequest)).thenThrow(Exception('test'));

      // Act
      final result = await repository.getResult(tRequest);

      // Assert
      expect(result, isA<Left>());
      // Expect UnknownFailure from error_mapper since it's just Exception
      result.fold(
        (failure) => expect(failure, isA<UnknownFailure>()),
        (_) => fail('Should be left'),
      );
    });
  });

  group('getResultLeaderboard', () {
    const tRequest = ResultsTestFixtures.tGetResultLeaderboardRequest;
    final tResponse = ResultsTestFixtures.tGetResultLeaderboardResponse;

    test('should return GetResultLeaderboardResponse when successful', () async {
      // Arrange
      when(mockRemoteDataSource.getResultLeaderboard(tRequest)).thenAnswer((_) async => tResponse);

      // Act
      final result = await repository.getResultLeaderboard(tRequest);

      // Assert
      expect(result, Right(tResponse));
    });
  });

  group('getResultQuestionsDetails', () {
    const tRequest = ResultsTestFixtures.tGetResultQuestionsDetailsRequest;
    final tResponse = ResultsTestFixtures.tGetResultQuestionsDetailsResponse;

    test('should return GetResultQuestionsDetailsResponse when successful', () async {
      // Arrange
      when(
        mockRemoteDataSource.getResultQuestionsDetails(tRequest),
      ).thenAnswer((_) async => tResponse);

      // Act
      final result = await repository.getResultQuestionsDetails(tRequest);

      // Assert
      expect(result, Right(tResponse));
    });
  });

  group('getAnswerEvaluations', () {
    const tRequest = ResultsTestFixtures.tGetAnswerEvaluationsRequest;
    final tResponse = ResultsTestFixtures.tGetAnswerEvaluationsResponse;

    test('should return GetAnswerEvaluationsResponse when successful', () async {
      // Arrange
      when(mockRemoteDataSource.getAnswerEvaluations(tRequest)).thenAnswer((_) async => tResponse);

      // Act
      final result = await repository.getAnswerEvaluations(tRequest);

      // Assert
      expect(result, Right(tResponse));
    });

    test('should catch CacheEmptyException and map to CacheFailure', () async {
      // Arrange
      when(
        mockRemoteDataSource.getAnswerEvaluations(tRequest),
      ).thenThrow(const CacheEmptyException(message: 'Cache empty'));

      // Act
      final result = await repository.getAnswerEvaluations(tRequest);

      // Assert
      expect(result, const Left(CacheFailure(message: 'Cache empty')));
    });
  });
}
