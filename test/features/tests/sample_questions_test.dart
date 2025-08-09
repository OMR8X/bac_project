import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/tests/data/models/question_model.dart';
import 'package:bac_project/features/tests/domain/entities/question.dart';
import 'package:bac_project/features/tests/domain/entities/option.dart';
import '../../fixtures/sample_questions_generator.dart';

void main() {
  group('Sample Questions Generator Tests', () {
    test('should generate 10 sample questions with Arabic text', () {
      // Act
      final questions = SampleQuestionsGenerator.generateSampleQuestions();

      // Assert
      expect(questions.length, equals(10));

      // Verify each question has the required properties
      for (final question in questions) {
        expect(question.id, isNotEmpty);
        expect(question.text, isNotEmpty);
        expect(question.options.length, equals(4));
        expect(question.category, isNotEmpty);
        expect(question.unitId, isNotNull);
        expect(question.lessonId, isNotNull);

        // Verify exactly one correct answer
        final correctAnswers = question.options.where((option) => option.isCorrect).toList();
        expect(correctAnswers.length, equals(1));

        // Verify all options have text
        for (final option in question.options) {
          expect(option.text, isNotEmpty);
          expect(option.id, isNotEmpty);
        }
      }
    });

    test('should generate questions with Arabic lorem ipsum text', () {
      // Act
      final questions = SampleQuestionsGenerator.generateSampleQuestions();

      // Assert
      // Verify that questions contain Arabic text (checking for Arabic characters)
      for (final question in questions) {
        final hasArabicText = RegExp(r'[\u0600-\u06FF]').hasMatch(question.text);
        expect(hasArabicText, isTrue, reason: 'Question text should contain Arabic characters');

        // Verify options also contain Arabic text
        for (final option in question.options) {
          final hasArabicOption = RegExp(r'[\u0600-\u06FF]').hasMatch(option.text);
          expect(hasArabicOption, isTrue, reason: 'Option text should contain Arabic characters');
        }
      }
    });

    test('should generate questions as JSON with correct structure', () {
      // Act
      final questionsJson = SampleQuestionsGenerator.generateSampleQuestionsAsJson();

      // Assert
      expect(questionsJson.length, equals(10));

      for (final questionJson in questionsJson) {
        expect(questionJson['id'], isA<String>());
        expect(questionJson['text'], isA<String>());
        expect(questionJson['options'], isA<List>());
        expect(questionJson['category'], isA<String>());
        expect(questionJson['unitId'], isA<String>());
        expect(questionJson['lessonId'], isA<String>());

        // Verify options structure
        final options = questionJson['options'] as List;
        expect(options.length, equals(4));

        int correctCount = 0;
        for (final option in options) {
          expect(option['text'], isA<String>());
          expect(option['isCorrect'], isA<bool>());
          if (option['isCorrect'] as bool) {
            correctCount++;
          }
        }
        expect(
          correctCount,
          equals(1),
          reason: 'Each question should have exactly one correct answer',
        );
      }
    });

    test('should create QuestionModel objects that can be converted to entities', () {
      // Act
      final questions = SampleQuestionsGenerator.generateSampleQuestions();

      // Assert
      for (final questionModel in questions) {
        expect(questionModel, isA<QuestionModel>());
        expect(questionModel, isA<Question>());

        // Test that we can create entities from the models
        final entity = questionModel.toEntity();
        expect(entity, isA<Question>());
        expect(entity.id, equals(questionModel.id));
        expect(entity.text, equals(questionModel.text));
        expect(entity.category, equals(questionModel.category));
        expect(entity.unitId, equals(questionModel.unitId));
        expect(entity.lessonId, equals(questionModel.lessonId));
        expect(entity.options.length, equals(questionModel.options.length));
      }
    });

    test('should generate sample question in exact JSON format from example', () {
      // Act
      final sampleJson = SampleQuestionsGenerator.generateSampleQuestionJson();

      // Assert
      expect(sampleJson['id'], equals('1'));
      expect(sampleJson['text'], equals('ما هو الجهاز المسؤول عن التنسيق العصبي في جسم الإنسان؟'));
      expect(sampleJson['category'], equals('1'));
      expect(sampleJson['unitId'], equals('1'));
      expect(sampleJson['lessonId'], equals('1'));

      final options = sampleJson['options'] as List;
      expect(options.length, equals(4));

      // Verify the correct answer
      final correctOption = options.firstWhere((option) => option['isCorrect'] == true);
      expect(correctOption['text'], equals('الجهاز العصبي'));

      // Verify wrong answers
      final wrongOptions = options.where((option) => option['isCorrect'] == false).toList();
      expect(wrongOptions.length, equals(3));

      final wrongAnswerTexts = wrongOptions.map((option) => option['text']).toList();
      expect(wrongAnswerTexts, containsAll(['الجهاز الهضمي', 'الجهاز التنفسي', 'الجهاز الدوري']));
    });

    test('should validate question logic - trueAnswers method', () {
      // Arrange
      final questions = SampleQuestionsGenerator.generateSampleQuestions();

      // Act & Assert
      for (final question in questions) {
        final correctOption = question.options.firstWhere((option) => option.isCorrect);
        final wrongOptions = question.options.where((option) => !option.isCorrect).toList();

        // Test correct answer validation
        expect(question.trueAnswers(correctOption.id), isTrue);

        // Test wrong answer validation
        for (final wrongOption in wrongOptions) {
          expect(question.trueAnswers(wrongOption.id), isFalse);
        }

        // Test invalid answer ID
        expect(question.trueAnswers('invalid_id'), isFalse);
      }
    });

    test('should have diverse categories and units', () {
      // Act
      final questions = SampleQuestionsGenerator.generateSampleQuestions();

      // Assert
      final categories = questions.map((q) => q.category).toSet();
      final units = questions.map((q) => q.unitId).toSet();
      final lessons = questions.map((q) => q.lessonId).toSet();

      expect(categories.length, greaterThan(1), reason: 'Should have multiple categories');
      expect(units.length, greaterThan(1), reason: 'Should have multiple units');
      expect(lessons.length, greaterThan(1), reason: 'Should have multiple lessons');
    });

    test('should create questions with shuffled option order', () {
      // Act - Generate questions multiple times to test randomization
      final questions1 = SampleQuestionsGenerator.generateSampleQuestions();
      final questions2 = SampleQuestionsGenerator.generateSampleQuestions();

      // Assert - Check that at least some questions have different option orders
      bool foundDifferentOrder = false;
      for (int i = 0; i < questions1.length; i++) {
        final q1Options = questions1[i].options.map((o) => o.text).toList();
        final q2Options = questions2[i].options.map((o) => o.text).toList();

        // If we find at least one question with different option order, the shuffle is working
        if (q1Options.join(',') != q2Options.join(',')) {
          foundDifferentOrder = true;
          break;
        }
      }

      // Note: This test might occasionally fail due to randomness, but it's very unlikely
      // that all 10 questions would have the exact same option order twice in a row
      expect(foundDifferentOrder, isTrue, reason: 'Options should be shuffled');
    });
  });

  group('Question Model Integration Tests', () {
    test('should be able to serialize and deserialize generated questions', () {
      // Arrange
      final originalQuestions = SampleQuestionsGenerator.generateSampleQuestions();

      // Act & Assert
      for (final originalQuestion in originalQuestions) {
        // Convert to JSON and back
        final json = originalQuestion.toJson();
        final deserializedQuestion = QuestionModel.fromJson(json);

        // Verify the deserialized question matches the original
        expect(deserializedQuestion.id, equals(originalQuestion.id));
        expect(deserializedQuestion.text, equals(originalQuestion.text));
        expect(deserializedQuestion.category, equals(originalQuestion.category));
        expect(deserializedQuestion.unitId, equals(originalQuestion.unitId));
        expect(deserializedQuestion.lessonId, equals(originalQuestion.lessonId));
        expect(deserializedQuestion.options.length, equals(originalQuestion.options.length));

        // Verify options
        for (int i = 0; i < originalQuestion.options.length; i++) {
          expect(deserializedQuestion.options[i].text, equals(originalQuestion.options[i].text));
          expect(
            deserializedQuestion.options[i].isCorrect,
            equals(originalQuestion.options[i].isCorrect),
          );
        }
      }
    });
  });
}
