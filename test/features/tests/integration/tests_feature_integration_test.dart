import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/domain/entities/unit.dart' as entities;
import 'package:bac_project/features/tests/domain/entities/lesson.dart' as entities;
import 'package:bac_project/features/tests/domain/entities/test_mode.dart' as entities;
import 'package:bac_project/features/tests/domain/requests/get_units_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_lessons_request.dart';
import 'package:bac_project/features/tests/domain/requests/get_test_options_request.dart';
import 'package:bac_project/features/tests/domain/usecases/get_units_use_case.dart';
import 'package:bac_project/features/tests/domain/usecases/get_lessons_use_case.dart';
import 'package:bac_project/features/tests/domain/usecases/get_test_options_use_case.dart';
import 'package:bac_project/features/tests/data/repositories/tests_repository_impl.dart';
import 'package:bac_project/features/tests/data/datasources/tests_remote_data_source_impl.dart';

void main() {
  late GetUnitsUsecase getUnitsUsecase;
  late GetLessonsUsecase getLessonsUsecase;
  late GetTestOptionsUsecase getTestOptionsUsecase;
  late TestsRepositoryImpl repository;
  late TestsRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = TestsRemoteDataSourceImpl();
    repository = TestsRepositoryImpl(remoteDataSource: dataSource);
    getUnitsUsecase = GetUnitsUsecase(repository: repository);
    getLessonsUsecase = GetLessonsUsecase(repository: repository);
    getTestOptionsUsecase = GetTestOptionsUsecase(repository: repository);
  });

  group('Tests Feature Integration Tests', () {
    test('should get all units successfully', () async {
      // act
      final result = await getUnitsUsecase.call(const GetUnitsRequest());

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.units.length, 5);
        expect(response.totalCount, 5);
        expect(response.units.first.title, 'الوحدة الأولى');
        expect(response.units.first.subtitle, 'مقدمة في الرياضيات');
      });
    });

    test('should get units with pagination', () async {
      // arrange
      const request = GetUnitsRequest();

      // act
      final result = await getUnitsUsecase.call(request);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.units.length, 5);
        expect(response.totalCount, 5);
      });
    });

    test('should get all lessons successfully', () async {
      // act
      final result = await getLessonsUsecase.call(const GetLessonsRequest());

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.lessons.length, 10); // First 10 lessons due to default pagination
        expect(response.totalCount, 13);
        expect(response.lessons.first.title, 'الأعداد الطبيعية');
        expect(response.lessons.first.questionsLength, 15);
        expect(response.lessons.first.unitId, '1');
      });
    });

    test('should get lessons filtered by unit ID', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '1');

      // act
      final result = await getLessonsUsecase.call(request);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.lessons.length, 3);
        expect(response.totalCount, 3);

        // Verify all lessons belong to unit 1
        for (final lesson in response.lessons) {
          expect(lesson.unitId, '1');
        }

        // Verify specific lessons
        expect(response.lessons[0].title, 'الأعداد الطبيعية');
        expect(response.lessons[1].title, 'العمليات الحسابية');
        expect(response.lessons[2].title, 'الكسور والأعداد العشرية');
      });
    });

    test('should get lessons for unit 2', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '2');

      // act
      final result = await getLessonsUsecase.call(request);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.lessons.length, 3);
        expect(response.totalCount, 3);

        // Verify all lessons belong to unit 2
        for (final lesson in response.lessons) {
          expect(lesson.unitId, '2');
        }
      });
    });

    test('should get lessons with pagination and filtering', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '3');

      // act
      final result = await getLessonsUsecase.call(request);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.lessons.length, 2);
        expect(response.totalCount, 3);

        // Verify all lessons belong to unit 3
        for (final lesson in response.lessons) {
          expect(lesson.unitId, '3');
        }
      });
    });

    test('should return empty list for non-existent unit', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '999');

      // act
      final result = await getLessonsUsecase.call(request);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.lessons.length, 0);
        expect(response.totalCount, 0);
      });
    });

    test('should verify lesson questions length variety', () async {
      // arrange
      const request = GetLessonsRequest(unitId: '3');

      // act
      final result = await getLessonsUsecase.call(request);

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.lessons.length, 3);

        // Verify question lengths are different
        final questionLengths = response.lessons.map((l) => l.questionsLength).toList();
        expect(questionLengths, [30, 28, 32]);
      });
    });

    test('should simulate network delay', () async {
      // arrange
      final stopwatch = Stopwatch()..start();
      const request = GetUnitsRequest();

      // act
      final result = await getUnitsUsecase.call(request);

      // assert
      stopwatch.stop();
      expect(result.isRight(), true);
      // Verify it took at least the simulated delay (500ms for units)
      expect(stopwatch.elapsedMilliseconds, greaterThan(400));
    });

    group('GetTestOptions Integration Tests', () {
      test('should get default test options successfully', () async {
        // act
        final result = await getTestOptionsUsecase.call(const GetTestOptionsRequest());

        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
          response,
        ) {
          expect(response.testOptions.id, equals('default_options'));
          expect(response.testOptions.unitIds, isNull);
          expect(response.testOptions.lessonIds, isNull);
          expect(response.testOptions.defaultMode, equals(entities.TestMode.exploring));
          expect(response.testOptions.modeSettings.length, equals(2));
          expect(response.testOptions.modeSettings.containsKey(entities.TestMode.testing), isTrue);
          expect(
            response.testOptions.modeSettings.containsKey(entities.TestMode.exploring),
            isTrue,
          );
        });
      });

      test('should get test options for specific unit', () async {
        // arrange
        const request = GetTestOptionsRequest(unitIds: ['2']);

        // act
        final result = await getTestOptionsUsecase.call(request);

        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
          response,
        ) {
          expect(response.testOptions.id, equals('units_2_options'));
          expect(response.testOptions.unitIds, equals(['2']));
          expect(response.testOptions.lessonIds, isNull);
          expect(response.testOptions.defaultMode, equals(entities.TestMode.exploring));
        });
      });

      test('should get test options for specific lesson', () async {
        // arrange
        const request = GetTestOptionsRequest(lessonIds: ['7']);

        // act
        final result = await getTestOptionsUsecase.call(request);

        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
          response,
        ) {
          expect(response.testOptions.id, equals('lessons_7_options'));
          expect(response.testOptions.unitIds, isNull);
          expect(response.testOptions.lessonIds, equals(['7']));
          expect(response.testOptions.defaultMode, equals(entities.TestMode.exploring));
        });
      });

      test('should verify test options mode settings structure', () async {
        // act
        final result = await getTestOptionsUsecase.call(const GetTestOptionsRequest());

        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
          response,
        ) {
          final testingSettings = response.testOptions.modeSettings[entities.TestMode.testing]!;
          final exploringSettings = response.testOptions.modeSettings[entities.TestMode.exploring]!;

          // Verify testing mode settings
          expect(testingSettings.canSelectCategories, isTrue);
          expect(testingSettings.canSelectQuestionCount, isFalse);
          expect(testingSettings.canToggleShowCorrectAnswer, isFalse);
          expect(testingSettings.canToggleSoundEffects, isTrue);
          expect(testingSettings.availableQuestionCounts, equals([20]));
          expect(testingSettings.defaultQuestionCount, equals(20));

          // Verify exploring mode settings
          expect(exploringSettings.canSelectCategories, isTrue);
          expect(exploringSettings.canSelectQuestionCount, isTrue);
          expect(exploringSettings.canToggleShowCorrectAnswer, isTrue);
          expect(exploringSettings.canToggleSoundEffects, isTrue);
          expect(exploringSettings.availableQuestionCounts, equals([10, 20, 30, 35]));
          expect(exploringSettings.defaultQuestionCount, equals(10));

          // Verify categories are the same
          expect(
            testingSettings.availableCategories,
            equals(exploringSettings.availableCategories),
          );
          expect(testingSettings.availableCategories.length, equals(5));
        });
      });

      test('should handle network delay simulation', () async {
        // arrange
        const request = GetTestOptionsRequest(unitIds: ['1']);
        final stopwatch = Stopwatch()..start();

        // act
        final result = await getTestOptionsUsecase.call(request);

        // assert
        stopwatch.stop();
        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(200));
        expect(result.isRight(), true);
      });

      test('should maintain data consistency across multiple calls', () async {
        // arrange
        const request = GetTestOptionsRequest(lessonIds: ['5']);

        // act
        final result1 = await getTestOptionsUsecase.call(request);
        final result2 = await getTestOptionsUsecase.call(request);

        // assert
        expect(result1.isRight(), true);
        expect(result2.isRight(), true);

        result1.fold((failure) => fail('First call failed: ${failure.message}'), (response1) {
          result2.fold((failure) => fail('Second call failed: ${failure.message}'), (response2) {
            expect(response1.testOptions.id, equals(response2.testOptions.id));
            expect(response1.testOptions.unitIds, equals(response2.testOptions.unitIds));
            expect(response1.testOptions.lessonIds, equals(response2.testOptions.lessonIds));
            expect(response1.testOptions.defaultMode, equals(response2.testOptions.defaultMode));
            expect(
              response1.testOptions.modeSettings.length,
              equals(response2.testOptions.modeSettings.length),
            );
          });
        });
      });

      test('should verify complete data flow from data source to use case', () async {
        // arrange
        const request = GetTestOptionsRequest(unitIds: ['3'], lessonIds: ['9']);

        // act
        final result = await getTestOptionsUsecase.call(request);

        // assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
          response,
        ) {
          // Verify data source logic: unitIds takes precedence over lessonIds
          expect(response.testOptions.id, equals('units_3_options'));
          expect(response.testOptions.unitIds, equals(['3']));
          expect(response.testOptions.lessonIds, isNull);

          // Verify all mode settings are properly mapped from model to entity
          expect(
            response.testOptions.modeSettings,
            isA<Map<entities.TestMode, entities.ModeSettings>>(),
          );
          expect(response.testOptions.defaultMode, isA<entities.TestMode>());

          // Verify the entity methods work correctly
          final testingSettings = response.testOptions.getSettingsForMode(
            entities.TestMode.testing,
          );
          final exploringSettings = response.testOptions.getSettingsForMode(
            entities.TestMode.exploring,
          );
          expect(testingSettings, isNotNull);
          expect(exploringSettings, isNotNull);

          // Verify available modes
          final availableModes = response.testOptions.availableModes;
          expect(availableModes.length, equals(2));
          expect(availableModes.contains(entities.TestMode.testing), isTrue);
          expect(availableModes.contains(entities.TestMode.exploring), isTrue);
        });
      });
    });
  });
}
