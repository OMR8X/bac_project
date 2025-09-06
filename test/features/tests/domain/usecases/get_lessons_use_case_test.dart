import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/domain/entities/lesson.dart' as entities;
import 'package:bac_project/features/tests/domain/repositories/tests_repository.dart';
import 'package:bac_project/features/tests/domain/requests/get_lessons_request.dart';
import 'package:bac_project/features/tests/data/responses/get_lessons_response.dart';
import 'package:bac_project/features/tests/domain/usecases/get_lessons_use_case.dart';

import 'get_lessons_use_case_test.mocks.dart';

@GenerateMocks([TestsRepository])
void main() {
  late GetLessonsUsecase useCase;
  late MockTestsRepository mockRepository;

  setUp(() {
    mockRepository = MockTestsRepository();
    useCase = GetLessonsUsecase(repository: mockRepository);
  });

  group('GetLessonsUsecase', () {
    const testLessons = [
      entities.Lesson(id: '1', title: 'الأعداد الطبيعية', questionsLength: 15, unitId: '1'),
      entities.Lesson(id: '2', title: 'العمليات الحسابية', questionsLength: 20, unitId: '1'),
      entities.Lesson(id: '3', title: 'المعادلات الخطية', questionsLength: 25, unitId: '2'),
    ];

    const testResponse = GetLessonsResponse(lessons: testLessons, totalCount: 3);

    test('should return GetLessonsResponse when repository call is successful', () async {
      // arrange
      const request = GetLessonsRequest();
      when(mockRepository.getLessons(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(testResponse));
      verify(mockRepository.getLessons(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return filtered lessons when unitId is provided', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '1');
      const filteredLessons = [
        entities.Lesson(id: '1', title: 'الأعداد الطبيعية', questionsLength: 15, unitId: '1'),
        entities.Lesson(id: '2', title: 'العمليات الحسابية', questionsLength: 20, unitId: '1'),
      ];
      const filteredResponse = GetLessonsResponse(lessons: filteredLessons, totalCount: 2);

      when(
        mockRepository.getLessons(request),
      ).thenAnswer((_) async => const Right(filteredResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(filteredResponse));
      verify(mockRepository.getLessons(request));
    });

    test('should return GetLessonsResponse when request has no parameters', () async {
      // arrange
      const request = GetLessonsRequest();
      when(mockRepository.getLessons(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(testResponse));
      verify(mockRepository.getLessons(request));
    });

    test('should return ServerFailure when repository throws ServerException', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '1');
      const failure = ServerFailure(message: 'Server error occurred');
      when(mockRepository.getLessons(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getLessons(request));
    });

    test('should return AuthFailure when repository throws AuthException', () async {
      // arrange
      const request = GetLessonsRequest();
      const failure = AuthFailure(message: 'Authentication failed');
      when(mockRepository.getLessons(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getLessons(request));
    });

    test('should return AnonFailure when repository throws unknown exception', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '2');
      const failure = AnonFailure(message: 'Unknown error occurred');
      when(mockRepository.getLessons(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getLessons(request));
    });

    test('should return empty list when no lessons available for unit', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '999');
      const emptyResponse = GetLessonsResponse(lessons: [], totalCount: 0);
      when(mockRepository.getLessons(request)).thenAnswer((_) async => const Right(emptyResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(emptyResponse));
      verify(mockRepository.getLessons(request));
    });

    test('should pass correct request parameters to repository', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '2');
      when(mockRepository.getLessons(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      await useCase.call(request);

      // assert
      verify(mockRepository.getLessons(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should handle lessons with different question lengths', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '3');
      const lessonsWithVariedQuestions = [
        entities.Lesson(id: '7', title: 'النهايات', questionsLength: 30, unitId: '3'),
        entities.Lesson(id: '8', title: 'الاشتقاق', questionsLength: 28, unitId: '3'),
        entities.Lesson(id: '9', title: 'التكامل', questionsLength: 32, unitId: '3'),
      ];
      const responseWithVariedQuestions = GetLessonsResponse(
        lessons: lessonsWithVariedQuestions,
        totalCount: 3,
      );

      when(
        mockRepository.getLessons(request),
      ).thenAnswer((_) async => const Right(responseWithVariedQuestions));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(responseWithVariedQuestions));
      verify(mockRepository.getLessons(request));
    });
  });
}
