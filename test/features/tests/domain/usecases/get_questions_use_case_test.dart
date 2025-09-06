import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart' as entities;
import 'package:bac_project/features/tests/domain/entities/option.dart' as entities;
import 'package:bac_project/features/tests/domain/repositories/tests_repository.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_request.dart';
import 'package:bac_project/features/tests/data/responses/get_questions_response.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_use_case.dart';

import 'get_questions_use_case_test.mocks.dart';

@GenerateMocks([TestsRepository])
void main() {
  late GetQuestionsUsecase useCase;
  late MockTestsRepository mockRepository;

  setUp(() {
    mockRepository = MockTestsRepository();
    useCase = GetQuestionsUsecase(repository: mockRepository);
  });

  group('GetQuestionsUsecase', () {
    const testQuestions = [
      entities.Question(
        id: '1',
        text: 'ما هو الجهاز المسؤول عن التنسيق العصبي في جسم الإنسان؟',
        options: [
          entities.Answer(id: '1_1', text: 'الجهاز العصبي', isCorrect: true),
          entities.Answer(id: '1_2', text: 'الجهاز الهضمي', isCorrect: false),
        ],
        category: 'biology',
        unitId: '1',
        lessonId: '1',
      ),
      entities.Question(
        id: '2',
        text: 'ما هي الوحدة الأساسية للجهاز العصبي؟',
        options: [
          entities.Answer(id: '2_1', text: 'الخلية العصبية', isCorrect: true),
          entities.Answer(id: '2_2', text: 'الخلية العضلية', isCorrect: false),
        ],
        category: 'biology',
        unitId: '1',
        lessonId: '1',
      ),
    ];

    const testResponse = GetQuestionsResponse(questions: testQuestions);

    test('should return GetQuestionsResponse when repository call is successful', () async {
      // arrange
      const request = GetQuestionsRequest(lessonId: '1');
      when(mockRepository.getQuestions(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(testResponse));
      verify(mockRepository.getQuestions(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return filtered questions for specific lesson', () async {
      // arrange
      const request = GetQuestionsRequest(lessonId: '2');
      const filteredQuestions = [
        entities.Question(
          id: '3',
          text: 'ما هو النسيج المكون من الخلايا العصبية؟',
          options: [
            entities.Answer(id: '3_1', text: 'النسيج العصبي', isCorrect: true),
            entities.Answer(id: '3_2', text: 'النسيج العضلي', isCorrect: false),
          ],
          category: 'biology',
          unitId: '1',
          lessonId: '2',
        ),
      ];
      const filteredResponse = GetQuestionsResponse(questions: filteredQuestions);

      when(
        mockRepository.getQuestions(request),
      ).thenAnswer((_) async => const Right(filteredResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(filteredResponse));
      verify(mockRepository.getQuestions(request));
    });

    test('should return empty list when no questions available for lesson', () async {
      // arrange
      const request = GetQuestionsRequest(lessonId: '999');
      const emptyResponse = GetQuestionsResponse(questions: []);
      when(
        mockRepository.getQuestions(request),
      ).thenAnswer((_) async => const Right(emptyResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(emptyResponse));
      verify(mockRepository.getQuestions(request));
    });

    test('should pass correct request parameters to repository', () async {
      // arrange
      const request = GetQuestionsRequest(lessonId: '5');
      when(mockRepository.getQuestions(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      await useCase.call(request);

      // assert
      verify(mockRepository.getQuestions(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return failure when repository call fails', () async {
      // arrange
      const request = GetQuestionsRequest(lessonId: '1');
      const failure = ServerFailure(message: 'Server error');
      when(mockRepository.getQuestions(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getQuestions(request));
    });
  });
}
