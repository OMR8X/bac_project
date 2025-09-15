import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/result_model.dart';
import 'package:bac_project/features/tests/data/models/result_answer_model.dart';
import 'package:bac_project/features/tests/domain/entities/result.dart';
import 'package:bac_project/features/tests/domain/entities/result_answer.dart';
import 'package:bac_project/features/tests/domain/entities/result_test_mode.dart';

void main() {
  group('ResultModel', () {
    late ResultModel resultModel;
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
    });

    group('fromJson', () {
      test('should create ResultModel from valid JSON', () {
        // Arrange
        final json = {
          'id': 1,
          'user_id': 'user123',
          'lesson_id': 1,
          'lesson_title': 'Test Lesson',
          'result_order': 1,
          'total_questions': 10,
          'correct_answers': 8,
          'wrong_answers': 2,
          'score': 80.0,
          'duration_seconds': 300,
          'result_test_mode': 'testing',
          'answers': [
            {'id': 1, 'result_id': 1, 'question_id': 1, 'option_id': 1},
            {'id': 2, 'result_id': 1, 'question_id': 2, 'option_id': 2},
          ],
          'created_at': '2023-01-01T10:00:00Z',
          'updated_at': '2023-01-01T10:05:00Z',
        };

        // Act
        final result = ResultModel.fromJson(json);

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

      test('should create ResultModel from JSON with null optional fields', () {
        // Arrange
        final json = {
          'id': 1,
          'user_id': 'user123',
          'total_questions': 10,
          'correct_answers': 8,
          'wrong_answers': 2,
          'score': 80.0,
          'duration_seconds': 300,
          'answers': [],
          'created_at': '2023-01-01T10:00:00Z',
          'updated_at': '2023-01-01T10:05:00Z',
        };

        // Act
        final result = ResultModel.fromJson(json);

        // Assert
        expect(result.id, equals(1));
        expect(result.userId, equals('user123'));
        expect(result.lessonId, isNull);
        expect(result.lessonTitle, isNull);
        expect(result.resultOrder, isNull);
        expect(result.resultTestMode, isNull);
        expect(result.answers, isEmpty);
      });

      test('should handle different result test modes', () {
        // Arrange
        final json = {
          'id': 1,
          'user_id': 'user123',
          'total_questions': 10,
          'correct_answers': 8,
          'wrong_answers': 2,
          'score': 80.0,
          'duration_seconds': 300,
          'result_test_mode': 'exploring',
          'answers': [],
          'created_at': '2023-01-01T10:00:00Z',
          'updated_at': '2023-01-01T10:05:00Z',
        };

        // Act
        final result = ResultModel.fromJson(json);

        // Assert
        expect(result.resultTestMode, equals(ResultTestMode.exploring));
      });

      test('should handle null result test mode', () {
        // Arrange
        final json = {
          'id': 1,
          'user_id': 'user123',
          'total_questions': 10,
          'correct_answers': 8,
          'wrong_answers': 2,
          'score': 80.0,
          'duration_seconds': 300,
          'result_test_mode': null,
          'answers': [],
          'created_at': '2023-01-01T10:00:00Z',
          'updated_at': '2023-01-01T10:05:00Z',
        };

        // Act
        final result = ResultModel.fromJson(json);

        // Assert
        expect(result.resultTestMode, isNull);
      });
    });

    group('toJson', () {
      test('should convert ResultModel to JSON', () {
        // Act
        final result = resultModel.toJson();

        // Assert
        expect(result['id'], equals(1));
        expect(result['user_id'], equals('user123'));
        expect(result['lesson_id'], equals(1));
        expect(result['lesson_title'], equals('Test Lesson'));
        expect(result['result_order'], equals(1));
        expect(result['total_questions'], equals(10));
        expect(result['correct_answers'], equals(8));
        expect(result['wrong_answers'], equals(2));
        expect(result['score'], equals(80.0));
        expect(result['duration_seconds'], equals(300));
        expect(result['result_test_mode'], equals('testing'));
        expect(result['answers'], isA<List>());
        expect(result['created_at'], equals('2023-01-01T10:00:00.000Z'));
        expect(result['updated_at'], equals('2023-01-01T10:05:00.000Z'));
      });

      test('should handle null optional fields in JSON', () {
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
        final result = model.toJson();

        // Assert
        expect(result['lesson_id'], isNull);
        expect(result['lesson_title'], isNull);
        expect(result['result_order'], isNull);
        expect(result['result_test_mode'], isNull);
      });
    });

    group('copyWith', () {
      test('should create copy with updated fields', () {
        // Act
        final result = resultModel.copyWith(score: 90.0, correctAnswers: 9, wrongAnswers: 1);

        // Assert
        expect(result.id, equals(resultModel.id));
        expect(result.userId, equals(resultModel.userId));
        expect(result.score, equals(90.0));
        expect(result.correctAnswers, equals(9));
        expect(result.wrongAnswers, equals(1));
        expect(result.totalQuestions, equals(resultModel.totalQuestions));
        expect(result.durationSeconds, equals(resultModel.durationSeconds));
        expect(result.answers, equals(resultModel.answers));
        expect(result.createdAt, equals(resultModel.createdAt));
        expect(result.updatedAt, equals(resultModel.updatedAt));
      });

      test('should create copy with all fields updated', () {
        // Arrange
        final newAnswers = [const ResultAnswer(id: 3, resultId: 1, questionId: 3, optionId: 3)];

        // Act
        final result = resultModel.copyWith(
          id: 2,
          userId: 'user456',
          lessonId: 2,
          lessonTitle: 'New Lesson',
          resultOrder: 2,
          totalQuestions: 15,
          correctAnswers: 12,
          wrongAnswers: 3,
          score: 85.0,
          durationSeconds: 450,
          resultTestMode: ResultTestMode.exploring,
          answers: newAnswers,
          createdAt: DateTime.parse('2023-01-02T10:00:00Z'),
          updatedAt: DateTime.parse('2023-01-02T10:10:00Z'),
        );

        // Assert
        expect(result.id, equals(2));
        expect(result.userId, equals('user456'));
        expect(result.lessonId, equals(2));
        expect(result.lessonTitle, equals('New Lesson'));
        expect(result.resultOrder, equals(2));
        expect(result.totalQuestions, equals(15));
        expect(result.correctAnswers, equals(12));
        expect(result.wrongAnswers, equals(3));
        expect(result.score, equals(85.0));
        expect(result.durationSeconds, equals(450));
        expect(result.resultTestMode, equals(ResultTestMode.exploring));
        expect(result.answers, equals(newAnswers));
        expect(result.createdAt, equals(DateTime.parse('2023-01-02T10:00:00Z')));
        expect(result.updatedAt, equals(DateTime.parse('2023-01-02T10:10:00Z')));
      });
    });

    group('inheritance', () {
      test('should be instance of Result', () {
        // Assert
        expect(resultModel, isA<Result>());
      });
    });
  });
}
