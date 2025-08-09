import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/datasources/tests_remote_data_source_impl.dart';
import 'package:bac_project/features/tests/domain/requests/get_test_options_request.dart';
import 'package:bac_project/features/tests/data/responses/get_test_options_response.dart';
import 'package:bac_project/features/tests/data/models/test_options_model.dart';
import 'package:bac_project/features/tests/domain/entities/test_mode.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late TestsRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = TestsRemoteDataSourceImpl();
  });

  group('TestsRemoteDataSourceImpl - getTestOptions', () {
    test(
      'should return GetTestOptionsResponse with default options when no parameters provided',
      () async {
        // arrange
        const request = GetTestOptionsRequest();

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        expect(result, isA<GetTestOptionsResponse>());
        expect(result.testOptions.id, equals('default_options'));
        expect(result.testOptions.unitIds, isNull);
        expect(result.testOptions.lessonIds, isNull);
        expect(result.testOptions.defaultMode, equals(TestMode.exploring));
        expect(result.testOptions.modeSettings, isNotEmpty);
        expect(result.testOptions.modeSettings.containsKey(TestMode.testing), isTrue);
        expect(result.testOptions.modeSettings.containsKey(TestMode.exploring), isTrue);
      },
    );

    test(
      'should return GetTestOptionsResponse with unit-specific options when unitIds provided',
      () async {
        // arrange
        const request = GetTestOptionsRequest(unitIds: ['1']);

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        expect(result, isA<GetTestOptionsResponse>());
        expect(result.testOptions.id, equals('units_1_options'));
        expect(result.testOptions.unitIds, equals(['1']));
        expect(result.testOptions.lessonIds, isNull);
        expect(result.testOptions.defaultMode, equals(TestMode.exploring));
      },
    );

    test(
      'should return GetTestOptionsResponse with lesson-specific options when lessonIds provided',
      () async {
        // arrange
        const request = GetTestOptionsRequest(lessonIds: ['5']);

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        expect(result, isA<GetTestOptionsResponse>());
        expect(result.testOptions.id, equals('lessons_5_options'));
        expect(result.testOptions.unitIds, isNull);
        expect(result.testOptions.lessonIds, equals(['5']));
        expect(result.testOptions.defaultMode, equals(TestMode.exploring));
      },
    );

    test('should prefer unitIds over lessonIds when both are provided', () async {
      // arrange
      const request = GetTestOptionsRequest(unitIds: ['2'], lessonIds: ['10']);

      // act
      final result = await dataSource.getTestOptions(request);

      // assert
      expect(result, isA<GetTestOptionsResponse>());
      expect(result.testOptions.id, equals('units_2_options'));
      expect(result.testOptions.unitIds, equals(['2']));
      expect(result.testOptions.lessonIds, isNull);
    });

    test('should simulate network delay of 200ms', () async {
      // arrange
      const request = GetTestOptionsRequest();
      final stopwatch = Stopwatch()..start();

      // act
      await dataSource.getTestOptions(request);

      // assert
      stopwatch.stop();
      expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(200));
      expect(stopwatch.elapsedMilliseconds, lessThan(300)); // Allow some tolerance
    });

    group('Testing Mode Settings', () {
      test('should have correct testing mode settings', () async {
        // arrange
        const request = GetTestOptionsRequest();

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        final testingSettings = result.testOptions.modeSettings[TestMode.testing]!;
        expect(testingSettings.canSelectCategories, isTrue);
        expect(testingSettings.canSelectQuestionCount, isFalse);
        expect(testingSettings.canToggleShowCorrectAnswer, isFalse);
        expect(testingSettings.canToggleSoundEffects, isTrue);
        expect(testingSettings.availableCategories, isNotEmpty);
        expect(testingSettings.availableQuestionCounts, equals([20]));
        expect(testingSettings.defaultQuestionCount, equals(10));
      });

      test('should have expected categories for testing mode', () async {
        // arrange
        const request = GetTestOptionsRequest();

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        final testingSettings = result.testOptions.modeSettings[TestMode.testing]!;
        expect(testingSettings.availableCategories, contains('الجبر'));
        expect(testingSettings.availableCategories, contains('الهندسة'));
        expect(testingSettings.availableCategories, contains('التفاضل والتكامل'));
        expect(testingSettings.availableCategories, contains('الإحصاء'));
        expect(testingSettings.availableCategories, contains('الاحتمالات'));
      });
    });

    group('Exploring Mode Settings', () {
      test('should have correct exploring mode settings', () async {
        // arrange
        const request = GetTestOptionsRequest();

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        final exploringSettings = result.testOptions.modeSettings[TestMode.exploring]!;
        expect(exploringSettings.canSelectCategories, isTrue);
        expect(exploringSettings.canSelectQuestionCount, isTrue);
        expect(exploringSettings.canToggleShowCorrectAnswer, isTrue);
        expect(exploringSettings.canToggleSoundEffects, isTrue);
        expect(exploringSettings.availableCategories, isNotEmpty);
        expect(exploringSettings.availableQuestionCounts, equals([10, 20, 30, 35]));
        expect(exploringSettings.defaultQuestionCount, equals(10));
      });

      test('should have same categories for exploring mode as testing mode', () async {
        // arrange
        const request = GetTestOptionsRequest();

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        final testingSettings = result.testOptions.modeSettings[TestMode.testing]!;
        final exploringSettings = result.testOptions.modeSettings[TestMode.exploring]!;
        expect(exploringSettings.availableCategories, equals(testingSettings.availableCategories));
      });
    });

    group('Data Consistency', () {
      test('should return consistent data across multiple calls', () async {
        // arrange
        const request = GetTestOptionsRequest(unitIds: ['3']);

        // act
        final result1 = await dataSource.getTestOptions(request);
        final result2 = await dataSource.getTestOptions(request);

        // assert
        expect(result1.testOptions.id, equals(result2.testOptions.id));
        expect(result1.testOptions.unitIds, equals(result2.testOptions.unitIds));
        expect(result1.testOptions.lessonIds, equals(result2.testOptions.lessonIds));
        expect(result1.testOptions.defaultMode, equals(result2.testOptions.defaultMode));
        expect(
          result1.testOptions.modeSettings.keys,
          equals(result2.testOptions.modeSettings.keys),
        );
      });

      test('should maintain original fake data structure', () async {
        // arrange
        const request = GetTestOptionsRequest();

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        // Verify the structure matches the original fake data
        expect(result.testOptions.modeSettings.length, equals(2));
        expect(result.testOptions.modeSettings.keys, contains(TestMode.testing));
        expect(result.testOptions.modeSettings.keys, contains(TestMode.exploring));
      });
    });

    group('Edge Cases', () {
      test('should handle null unitIds gracefully', () async {
        // arrange
        const request = GetTestOptionsRequest(unitIds: null);

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        expect(result.testOptions.id, equals('default_options'));
        expect(result.testOptions.unitIds, isNull);
      });

      test('should handle null lessonIds gracefully', () async {
        // arrange
        const request = GetTestOptionsRequest(lessonIds: null);

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        expect(result.testOptions.id, equals('default_options'));
        expect(result.testOptions.lessonIds, isNull);
      });

      test('should work with empty string unitIds', () async {
        // arrange
        const request = GetTestOptionsRequest(unitIds: ['']);

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        expect(result.testOptions.id, equals('units__options'));
        expect(result.testOptions.unitIds, equals(['']));
      });

      test('should work with very long IDs', () async {
        // arrange
        const longId = 'very_long_unit_id_with_many_characters_12345';
        const request = GetTestOptionsRequest(unitIds: [longId]);

        // act
        final result = await dataSource.getTestOptions(request);

        // assert
        expect(result.testOptions.id, equals('units_${longId}_options'));
        expect(result.testOptions.unitIds, equals([longId]));
      });
    });
  });
}
