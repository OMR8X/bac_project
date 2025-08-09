import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';
import 'package:bac_project/features/tests/domain/repositories/tests_repository.dart';
import 'package:bac_project/features/tests/domain/requests/get_test_options_request.dart';
import 'package:bac_project/features/tests/data/responses/get_test_options_response.dart';
import 'package:bac_project/features/tests/domain/usecases/get_test_options_use_case.dart';

import 'get_test_options_use_case_test.mocks.dart';

@GenerateMocks([TestsRepository])
void main() {
  late GetTestOptionsUseCase useCase;
  late MockTestsRepository mockRepository;

  setUp(() {
    mockRepository = MockTestsRepository();
    useCase = GetTestOptionsUseCase(repository: mockRepository);
  });

  group('GetTestOptionsUseCase', () {
    const testModeSettings = {
      TestMode.testing: ModeSettings(
        canSelectCategories: true,
        canSelectQuestionCount: false,
        canToggleShowCorrectAnswer: false,
        canToggleSoundEffects: true,
        availableCategories: ['الجبر', 'الهندسة'],
        availableQuestionCounts: [20],
        defaultQuestionCount: 20,
      ),
      TestMode.exploring: ModeSettings(
        canSelectCategories: true,
        canSelectQuestionCount: true,
        canToggleShowCorrectAnswer: true,
        canToggleSoundEffects: true,
        availableCategories: ['الجبر', 'الهندسة', 'التفاضل والتكامل'],
        availableQuestionCounts: [10, 20, 30],
        defaultQuestionCount: 10,
      ),
    };

    const testTestOptions = TestOptions(
      id: 'default_options',
      unitIds: null,
      lessonIds: null,
      modeSettings: testModeSettings,
      defaultMode: TestMode.exploring,
    );

    const testResponse = GetTestOptionsResponse(testOptions: testTestOptions);

    test('should return GetTestOptionsResponse when repository call is successful', () async {
      // arrange
      const request = GetTestOptionsRequest();
      when(
        mockRepository.getTestOptions(request),
      ).thenAnswer((_) async => const Right(testResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(testResponse));
      verify(mockRepository.getTestOptions(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return test options for specific unit when unitIds is provided', () async {
      // arrange
      const request = GetTestOptionsRequest(unitIds: ['1']);
      const unitTestOptions = TestOptions(
        id: 'units_1_options',
        unitIds: ['1'],
        lessonIds: null,
        modeSettings: testModeSettings,
        defaultMode: TestMode.exploring,
      );
      const unitResponse = GetTestOptionsResponse(testOptions: unitTestOptions);

      when(
        mockRepository.getTestOptions(request),
      ).thenAnswer((_) async => const Right(unitResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(unitResponse));
      verify(mockRepository.getTestOptions(request));
    });

    test('should return test options for specific lesson when lessonIds is provided', () async {
      // arrange
      const request = GetTestOptionsRequest(lessonIds: ['1']);
      const lessonTestOptions = TestOptions(
        id: 'lessons_1_options',
        unitIds: null,
        lessonIds: ['1'],
        modeSettings: testModeSettings,
        defaultMode: TestMode.testing,
      );
      const lessonResponse = GetTestOptionsResponse(testOptions: lessonTestOptions);

      when(
        mockRepository.getTestOptions(request),
      ).thenAnswer((_) async => const Right(lessonResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(lessonResponse));
      verify(mockRepository.getTestOptions(request));
    });

    test('should return ServerFailure when repository call fails', () async {
      // arrange
      const request = GetTestOptionsRequest();
      const failure = ServerFailure(message: 'Failed to get test options');
      when(mockRepository.getTestOptions(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getTestOptions(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return CacheFailure when repository call fails with cache error', () async {
      // arrange
      const request = GetTestOptionsRequest(unitIds: ['2']);
      const failure = CacheFailure(message: 'Cache error occurred');
      when(mockRepository.getTestOptions(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getTestOptions(request));
    });

    test('should handle request with both unitIds and lessonIds', () async {
      // arrange
      const request = GetTestOptionsRequest(unitIds: ['1'], lessonIds: ['1']);
      const combinedTestOptions = TestOptions(
        id: 'lessons_1_options',
        unitIds: ['1'],
        lessonIds: ['1'],
        modeSettings: testModeSettings,
        defaultMode: TestMode.testing,
      );
      const combinedResponse = GetTestOptionsResponse(testOptions: combinedTestOptions);

      when(
        mockRepository.getTestOptions(request),
      ).thenAnswer((_) async => const Right(combinedResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(combinedResponse));
      verify(mockRepository.getTestOptions(request));
    });
  });
}
