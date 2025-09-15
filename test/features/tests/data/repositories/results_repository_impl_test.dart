import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/core/resources/errors/exceptions.dart';
import 'package:bac_project/features/tests/data/datasources/results_remote_data_source.dart';
import 'package:bac_project/features/tests/data/repositories/results_repository_impl.dart';
import 'package:bac_project/features/tests/domain/requests/add_result_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_my_results_request.dart';
import 'package:bac_project/features/tests/data/responses/add_result_response.dart';
import 'package:bac_project/features/tests/data/responses/get_results_response.dart';
import 'package:bac_project/features/tests/data/models/result_model.dart';
import 'package:bac_project/features/tests/data/models/user_answer_model.dart';

import 'results_repository_impl_test.mocks.dart';

@GenerateMocks([ResultsRemoteDataSource])
void main() {
  late ResultsRepositoryImpl repository;
  late MockResultsRemoteDataSource mockRemote;

  setUp(() {
    mockRemote = MockResultsRemoteDataSource();
    repository = ResultsRepositoryImpl(remoteDataSource: mockRemote);
  });

  group('ResultsRepositoryImpl', () {
    final now = DateTime.now();
    final sampleResult = ResultModel(
      id: 1,
      userId: 'user-1',
      lessonId: 2,
      totalQuestions: 2,
      correctAnswers: 1,
      wrongAnswers: 1,
      score: 50.0,
      durationSeconds: 120,
      answers: [],
      createdAt: now,
      updatedAt: now,
    );

    test('addResult should return Right(AddResultResponse) on success', () async {
      final request = AddResultRequest(
        lessonId: 1,
        questionsIds: [10, 11],
        durationSeconds: 120,
        answers: [const UserAnswerModel(questionId: 10, selectedOptionId: 100)],
      );
      final response = AddResultResponse(result: sampleResult);

      when(mockRemote.addResult(request)).thenAnswer((_) async => response);

      final result = await repository.addResult(request);

      expect(result, Right(response));
      verify(mockRemote.addResult(request));
    });

    test(
      'addResult should return Left(ServerFailure) when remote throws ServerException',
      () async {
        final request = AddResultRequest(
          lessonId: 1,
          questionsIds: [10],
          durationSeconds: 60,
          answers: [const UserAnswerModel(questionId: 10, selectedOptionId: 100)],
        );
        when(mockRemote.addResult(request)).thenThrow(const ServerException(message: 'server'));

        final result = await repository.addResult(request);

        expect(result, isA<Left>());
        result.fold((l) => expect(l, isA<ServerFailure>()), (_) {});
        verify(mockRemote.addResult(request));
      },
    );

    test('getMyResults should return Right(GetResultsResponse) on success', () async {
      final request = GetMyResultsRequest(lessonId: 2, limit: 10, offset: 0);
      final response = GetResultsResponse(results: [sampleResult]);

      when(mockRemote.getMyResults(request)).thenAnswer((_) async => response);

      final result = await repository.getMyResults(request);

      expect(result, Right(response));
      verify(mockRemote.getMyResults(request));
    });

    test('getMyResults should return Left(AuthFailure) when remote throws AuthException', () async {
      final request = GetMyResultsRequest(lessonId: null, limit: 5, offset: 0);
      when(mockRemote.getMyResults(request)).thenThrow(const AuthException(message: 'auth'));

      final result = await repository.getMyResults(request);

      expect(result, isA<Left>());
      result.fold((l) => expect(l, isA<AuthFailure>()), (_) {});
      verify(mockRemote.getMyResults(request));
    });
  });
}
