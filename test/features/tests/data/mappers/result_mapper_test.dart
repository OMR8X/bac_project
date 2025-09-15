import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/result_model.dart';
import 'package:bac_project/features/tests/data/mappers/result_mapper.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/entities/result_answer.dart';
import 'package:bac_project/features/tests/domain/entities/result_test_mode.dart';

void main() {
  group('ResultMapper', () {
    late ResultModel resultModel;
    late Result resultEntity;
    late List<ResultAnswer> testAnswers;

    setUp(() {
      testAnswers = [
        const ResultAnswer(id: 1, resultId: 1, questionId: 1, optionId: 1),
        const ResultAnswer(id: 2, resultId: 1, questionId: 2, optionId: 2),
      ];

      resultModel = ResultModel(
        id: 1,
        userId: 'user123',
        lessonId: 1,
        lessonTitle: 'Test Lesson',
        resultOrder: 1,
        totalQuestions: 10,
        correctAnswers: 8,
        wrongAnswers: 2,
        score: 80.0,
        durationSeconds: 300,
        resultTestMode: ResultTestMode.testing,
        answers: testAnswers,
        createdAt: DateTime.parse('2023-01-01T10:00:00Z'),
        updatedAt: DateTime.parse('2023-01-01T10:05:00Z'),
      );

      resultEntity = Result(
        id: 1,
        userId: 'user123',
        lessonId: 1,
        lessonTitle: 'Test Lesson',
        resultOrder: 1,
        totalQuestions: 10,
        correctAnswers: 8,
        wrongAnswers: 2,
        score: 80.0,
        durationSeconds: 300,
        resultTestMode: ResultTestMode.testing,
        answers: testAnswers,
        createdAt: DateTime.parse('2023-01-01T10:00:00Z'),
        updatedAt: DateTime.parse('2023-01-01T10:05:00Z'),
      );
    });

    group('ResultModelExtension.toEntity', () {
      test('should convert ResultModel to Result entity', () {
        // Act
        final result = resultModel.toEntity();

        // Assert
        expect(result, isA<Result>());
        expect(result.id, equals(resultModel.id));
        expect(result.userId, equals(resultModel.userId));
        expect(result.lessonId, equals(resultModel.lessonId));
        expect(result.lessonTitle, equals(resultModel.lessonTitle));
        expect(result.resultOrder, equals(resultModel.resultOrder));
        expect(result.totalQuestions, equals(resultModel.totalQuestions));
        expect(result.correctAnswers, equals(resultModel.correctAnswers));
        expect(result.wrongAnswers, equals(resultModel.wrongAnswers));
        expect(result.score, equals(resultModel.score));
        expect(result.durationSeconds, equals(resultModel.durationSeconds));
        expect(result.resultTestMode, equals(resultModel.resultTestMode));
        expect(result.answers, equals(resultModel.answers));
        expect(result.createdAt, equals(resultModel.createdAt));
        expect(result.updatedAt, equals(resultModel.updatedAt));
      });

      test('should handle null optional fields', () {
        // Arrange
        final model = ResultModel(
          id: 1,
          userId: 'user123',
          totalQuestions: 10,
          correctAnswers: 8,
          wrongAnswers: 2,
          score: 80.0,
          durationSeconds: 300,
          answers: [],
          createdAt: DateTime.parse('2023-01-01T10:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T10:05:00Z'),
        );

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.userId, equals('user123'));
        expect(result.lessonId, isNull);
        expect(result.lessonTitle, isNull);
        expect(result.resultOrder, isNull);
        expect(result.resultTestMode, isNull);
        expect(result.answers, isEmpty);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = resultModel.toEntity();

        // Assert
        expect(result.id, equals(1));
        expect(result.userId, equals('user123'));
        expect(result.lessonId, equals(1));
        expect(result.lessonTitle, equals('Test Lesson'));
        expect(result.resultOrder, equals(1));
        expect(result.totalQuestions, equals(10));
        expect(result.correctAnswers, equals(8));
        expect(result.wrongAnswers, equals(2));
        expect(result.score, equals(80.0));
        expect(result.durationSeconds, equals(300));
        expect(result.resultTestMode, equals(ResultTestMode.testing));
        expect(result.answers.length, equals(2));
        expect(result.createdAt, equals(DateTime.parse('2023-01-01T10:00:00Z')));
        expect(result.updatedAt, equals(DateTime.parse('2023-01-01T10:05:00Z')));
      });
    });

    group('ResultEntityExtension.toModel', () {
      test('should convert Result entity to ResultModel', () {
        // Act
        final result = resultEntity.toModel();

        // Assert
        expect(result, isA<ResultModel>());
        expect(result.id, equals(resultEntity.id));
        expect(result.userId, equals(resultEntity.userId));
        expect(result.lessonId, equals(resultEntity.lessonId));
        expect(result.lessonTitle, equals(resultEntity.lessonTitle));
        expect(result.resultOrder, equals(resultEntity.resultOrder));
        expect(result.totalQuestions, equals(resultEntity.totalQuestions));
        expect(result.correctAnswers, equals(resultEntity.correctAnswers));
        expect(result.wrongAnswers, equals(resultEntity.wrongAnswers));
        expect(result.score, equals(resultEntity.score));
        expect(result.durationSeconds, equals(resultEntity.durationSeconds));
        expect(result.resultTestMode, equals(resultEntity.resultTestMode));
        expect(result.answers, equals(resultEntity.answers));
        expect(result.createdAt, equals(resultEntity.createdAt));
        expect(result.updatedAt, equals(resultEntity.updatedAt));
      });

      test('should handle null optional fields', () {
        // Arrange
        final entity = Result(
          id: 1,
          userId: 'user123',
          totalQuestions: 10,
          correctAnswers: 8,
          wrongAnswers: 2,
          score: 80.0,
          durationSeconds: 300,
          answers: [],
          createdAt: DateTime.parse('2023-01-01T10:00:00Z'),
          updatedAt: DateTime.parse('2023-01-01T10:05:00Z'),
        );

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.userId, equals('user123'));
        expect(result.lessonId, isNull);
        expect(result.lessonTitle, isNull);
        expect(result.resultOrder, isNull);
        expect(result.resultTestMode, isNull);
        expect(result.answers, isEmpty);
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = resultEntity.toModel();

        // Assert
        expect(result.id, equals(1));
        expect(result.userId, equals('user123'));
        expect(result.lessonId, equals(1));
        expect(result.lessonTitle, equals('Test Lesson'));
        expect(result.resultOrder, equals(1));
        expect(result.totalQuestions, equals(10));
        expect(result.correctAnswers, equals(8));
        expect(result.wrongAnswers, equals(2));
        expect(result.score, equals(80.0));
        expect(result.durationSeconds, equals(300));
        expect(result.resultTestMode, equals(ResultTestMode.testing));
        expect(result.answers.length, equals(2));
        expect(result.createdAt, equals(DateTime.parse('2023-01-01T10:00:00Z')));
        expect(result.updatedAt, equals(DateTime.parse('2023-01-01T10:05:00Z')));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = resultModel.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.id, equals(resultModel.id));
        expect(backToModel.userId, equals(resultModel.userId));
        expect(backToModel.lessonId, equals(resultModel.lessonId));
        expect(backToModel.lessonTitle, equals(resultModel.lessonTitle));
        expect(backToModel.resultOrder, equals(resultModel.resultOrder));
        expect(backToModel.totalQuestions, equals(resultModel.totalQuestions));
        expect(backToModel.correctAnswers, equals(resultModel.correctAnswers));
        expect(backToModel.wrongAnswers, equals(resultModel.wrongAnswers));
        expect(backToModel.score, equals(resultModel.score));
        expect(backToModel.durationSeconds, equals(resultModel.durationSeconds));
        expect(backToModel.resultTestMode, equals(resultModel.resultTestMode));
        expect(backToModel.answers, equals(resultModel.answers));
        expect(backToModel.createdAt, equals(resultModel.createdAt));
        expect(backToModel.updatedAt, equals(resultModel.updatedAt));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = resultEntity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.id, equals(resultEntity.id));
        expect(backToEntity.userId, equals(resultEntity.userId));
        expect(backToEntity.lessonId, equals(resultEntity.lessonId));
        expect(backToEntity.lessonTitle, equals(resultEntity.lessonTitle));
        expect(backToEntity.resultOrder, equals(resultEntity.resultOrder));
        expect(backToEntity.totalQuestions, equals(resultEntity.totalQuestions));
        expect(backToEntity.correctAnswers, equals(resultEntity.correctAnswers));
        expect(backToEntity.wrongAnswers, equals(resultEntity.wrongAnswers));
        expect(backToEntity.score, equals(resultEntity.score));
        expect(backToEntity.durationSeconds, equals(resultEntity.durationSeconds));
        expect(backToEntity.resultTestMode, equals(resultEntity.resultTestMode));
        expect(backToEntity.answers, equals(resultEntity.answers));
        expect(backToEntity.createdAt, equals(resultEntity.createdAt));
        expect(backToEntity.updatedAt, equals(resultEntity.updatedAt));
      });
    });
  });
}
