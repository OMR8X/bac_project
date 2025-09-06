import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/domain/repositories/results_repository.dart';
import 'package:bac_project/features/tests/domain/requests/get_my_results_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_my_results_use_case.dart';
import 'package:bac_project/features/tests/data/responses/get_results_response.dart';
import 'package:bac_project/features/tests/data/models/result_model.dart';
import 'package:bac_project/features/tests/data/models/user_answer_model.dart';

import 'get_my_results_use_case_test.mocks.dart';

@GenerateMocks([ResultsRepository])
void main() {
  late GetMyResultsUsecase useCase;
  late MockResultsRepository mockRepository;

  setUp(() {
    mockRepository = MockResultsRepository();
    useCase = GetMyResultsUsecase(repository: mockRepository);
  });

  group('GetMyResultsUsecase', () {
    final now = DateTime.now();
    final sampleResult = ResultModel(
      id: 1,
      userId: 'user-1',
      lessonId: 2,
      questionsIds: [10, 11],
      totalQuestions: 2,
      correctAnswers: 1,
      wrongAnswers: 1,
      skippedAnswers: 0,
      score: 50.0,
      durationSeconds: 120,
      answers: [const UserAnswerModel(questionId: 10, selectedOptionId: 100)],
      createdAt: now,
      updatedAt: now,
    );

    final sampleResponse = GetResultsResponse(results: [sampleResult]);

    test('should return GetResultsResponse when repository call is successful', () async {
      // arrange
      final request = GetMyResultsRequest(lessonId: 2, limit: 10, offset: 0);
      when(mockRepository.getMyResults(request)).thenAnswer((_) async => Right(sampleResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, Right(sampleResponse));
      verify(mockRepository.getMyResults(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should forward failures from repository', () async {
      // arrange
      final request = GetMyResultsRequest(lessonId: null, limit: 5, offset: 0);
      const failure = ServerFailure(message: 'Server error');
      when(mockRepository.getMyResults(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getMyResults(request));
    });
  });
}
