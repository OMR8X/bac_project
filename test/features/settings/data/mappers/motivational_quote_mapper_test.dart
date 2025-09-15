import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/settings/data/models/motivational_quote_model.dart';
import 'package:bac_project/features/settings/data/mappers/motivational_quote_mapper.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';

void main() {
  group('MotivationalQuoteMapper', () {
    late MotivationalQuote motivationalQuoteEntity;
    late MotivationalQuoteModel motivationalQuoteModel;

    setUp(() {
      motivationalQuoteEntity = MotivationalQuote(
        quote: 'Success is not final, failure is not fatal',
        author: 'Winston Churchill',
        date: DateTime.parse('2023-01-01T10:00:00Z'),
      );

      motivationalQuoteModel = MotivationalQuoteModel(
        quote: 'Success is not final, failure is not fatal',
        author: 'Winston Churchill',
        date: DateTime.parse('2023-01-01T10:00:00Z'),
      );
    });

    group('MotivationalQuoteMapper.toModel', () {
      test('should convert MotivationalQuote entity to MotivationalQuoteModel', () {
        // Act
        final result = motivationalQuoteEntity.toModel();

        // Assert
        expect(result, isA<MotivationalQuoteModel>());
        expect(result.quote, equals(motivationalQuoteEntity.quote));
        expect(result.author, equals(motivationalQuoteEntity.author));
        expect(result.date, equals(motivationalQuoteEntity.date));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = motivationalQuoteEntity.toModel();

        // Assert
        expect(result.quote, equals('Success is not final, failure is not fatal'));
        expect(result.author, equals('Winston Churchill'));
        expect(result.date, equals(DateTime.parse('2023-01-01T10:00:00Z')));
      });

      test('should handle different values', () {
        // Arrange
        final entity = MotivationalQuote(
          quote: 'The only way to do great work is to love what you do',
          author: 'Steve Jobs',
          date: DateTime.parse('2023-01-02T15:30:00Z'),
        );

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.quote, equals('The only way to do great work is to love what you do'));
        expect(result.author, equals('Steve Jobs'));
        expect(result.date, equals(DateTime.parse('2023-01-02T15:30:00Z')));
      });

      test('should handle empty strings', () {
        // Arrange
        final entity = MotivationalQuote(
          quote: '',
          author: '',
          date: DateTime.parse('2023-01-01T10:00:00Z'),
        );

        // Act
        final result = entity.toModel();

        // Assert
        expect(result.quote, equals(''));
        expect(result.author, equals(''));
        expect(result.date, equals(DateTime.parse('2023-01-01T10:00:00Z')));
      });
    });

    group('MotivationalQuoteModelMapper.toEntity', () {
      test('should convert MotivationalQuoteModel to MotivationalQuote entity', () {
        // Act
        final result = motivationalQuoteModel.toEntity();

        // Assert
        expect(result, isA<MotivationalQuote>());
        expect(result.quote, equals(motivationalQuoteModel.quote));
        expect(result.author, equals(motivationalQuoteModel.author));
        expect(result.date, equals(motivationalQuoteModel.date));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = motivationalQuoteModel.toEntity();

        // Assert
        expect(result.quote, equals('Success is not final, failure is not fatal'));
        expect(result.author, equals('Winston Churchill'));
        expect(result.date, equals(DateTime.parse('2023-01-01T10:00:00Z')));
      });

      test('should handle different values', () {
        // Arrange
        final model = MotivationalQuoteModel(
          quote: 'The only way to do great work is to love what you do',
          author: 'Steve Jobs',
          date: DateTime.parse('2023-01-02T15:30:00Z'),
        );

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.quote, equals('The only way to do great work is to love what you do'));
        expect(result.author, equals('Steve Jobs'));
        expect(result.date, equals(DateTime.parse('2023-01-02T15:30:00Z')));
      });

      test('should handle empty strings', () {
        // Arrange
        final model = MotivationalQuoteModel(
          quote: '',
          author: '',
          date: DateTime.parse('2023-01-01T10:00:00Z'),
        );

        // Act
        final result = model.toEntity();

        // Assert
        expect(result.quote, equals(''));
        expect(result.author, equals(''));
        expect(result.date, equals(DateTime.parse('2023-01-01T10:00:00Z')));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = motivationalQuoteModel.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.quote, equals(motivationalQuoteModel.quote));
        expect(backToModel.author, equals(motivationalQuoteModel.author));
        expect(backToModel.date, equals(motivationalQuoteModel.date));
      });

      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = motivationalQuoteEntity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.quote, equals(motivationalQuoteEntity.quote));
        expect(backToEntity.author, equals(motivationalQuoteEntity.author));
        expect(backToEntity.date, equals(motivationalQuoteEntity.date));
      });

      test('should handle null date in round-trip conversion', () {
        // Arrange
        final entity = MotivationalQuote(
          quote: 'Test quote',
          author: 'Test Author',
          date: DateTime.parse('2023-01-01T10:00:00Z'),
        );

        // Act
        final model = entity.toModel();
        final backToEntity = model.toEntity();

        // Assert
        expect(backToEntity.quote, equals('Test quote'));
        expect(backToEntity.author, equals('Test Author'));
        expect(backToEntity.date, equals(DateTime.parse('2023-01-01T10:00:00Z')));
      });

      test('should handle different date values in round-trip conversion', () {
        // Arrange
        final model = MotivationalQuoteModel(
          quote: 'Test quote',
          author: 'Test Author',
          date: DateTime.parse('2023-12-31T23:59:59Z'),
        );

        // Act
        final entity = model.toEntity();
        final backToModel = entity.toModel();

        // Assert
        expect(backToModel.quote, equals('Test quote'));
        expect(backToModel.author, equals('Test Author'));
        expect(backToModel.date, equals(DateTime.parse('2023-12-31T23:59:59Z')));
      });
    });
  });
}
