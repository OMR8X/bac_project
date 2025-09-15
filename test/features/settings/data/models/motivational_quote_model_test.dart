import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/settings/data/models/motivational_quote_model.dart';
import 'package:bac_project/features/settings/domain/entities/motivational_quote.dart';

void main() {
  group('MotivationalQuoteModel', () {
    late MotivationalQuoteModel motivationalQuoteModel;

    setUp(() {
      motivationalQuoteModel = MotivationalQuoteModel(
        quote: 'Success is not final, failure is not fatal',
        author: 'Winston Churchill',
        date: DateTime.parse('2023-01-01T10:00:00Z'),
      );
    });

    group('fromJson', () {
      test('should create MotivationalQuoteModel from valid JSON', () {
        // Arrange
        final json = {
          'quote': 'Success is not final, failure is not fatal',
          'author': 'Winston Churchill',
          'date': '2023-01-01T10:00:00Z',
        };

        // Act
        final result = MotivationalQuoteModel.fromJson(json);

        // Assert
        expect(result.quote, equals('Success is not final, failure is not fatal'));
        expect(result.author, equals('Winston Churchill'));
        expect(result.date, equals(DateTime.parse('2023-01-01T10:00:00Z')));
      });

      test('should create MotivationalQuoteModel with different values', () {
        // Arrange
        final json = {
          'quote': 'The only way to do great work is to love what you do',
          'author': 'Steve Jobs',
          'date': '2023-01-02T15:30:00Z',
        };

        // Act
        final result = MotivationalQuoteModel.fromJson(json);

        // Assert
        expect(result.quote, equals('The only way to do great work is to love what you do'));
        expect(result.author, equals('Steve Jobs'));
        expect(result.date, equals(DateTime.parse('2023-01-02T15:30:00Z')));
      });

      test('should create MotivationalQuoteModel with null date using current time', () {
        // Arrange
        final json = {'quote': 'Test quote', 'author': 'Test Author', 'date': null};

        // Act
        final result = MotivationalQuoteModel.fromJson(json);

        // Assert
        expect(result.quote, equals('Test quote'));
        expect(result.author, equals('Test Author'));
        expect(result.date, isA<DateTime>());
        // Check that the date is recent (within the last minute)
        expect(result.date.isAfter(DateTime.now().subtract(const Duration(minutes: 1))), isTrue);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {'quote': '', 'author': '', 'date': '2023-01-01T10:00:00Z'};

        // Act
        final result = MotivationalQuoteModel.fromJson(json);

        // Assert
        expect(result.quote, equals(''));
        expect(result.author, equals(''));
        expect(result.date, equals(DateTime.parse('2023-01-01T10:00:00Z')));
      });
    });

    group('toJson', () {
      test('should convert MotivationalQuoteModel to JSON', () {
        // Act
        final result = motivationalQuoteModel.toJson();

        // Assert
        expect(result['quote'], equals('Success is not final, failure is not fatal'));
        expect(result['author'], equals('Winston Churchill'));
        expect(result['date'], equals('2023-01-01T10:00:00.000Z'));
      });

      test('should convert different MotivationalQuoteModel to JSON', () {
        // Arrange
        final model = MotivationalQuoteModel(
          quote: 'Be yourself; everyone else is already taken',
          author: 'Oscar Wilde',
          date: DateTime.parse('2023-01-03T12:00:00Z'),
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['quote'], equals('Be yourself; everyone else is already taken'));
        expect(result['author'], equals('Oscar Wilde'));
        expect(result['date'], equals('2023-01-03T12:00:00.000Z'));
      });

      test('should handle different date formats in JSON', () {
        // Arrange
        final model = MotivationalQuoteModel(
          quote: 'Test quote',
          author: 'Test Author',
          date: DateTime.parse('2023-12-31T23:59:59Z'),
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['date'], equals('2023-12-31T23:59:59.000Z'));
      });
    });

    group('inheritance', () {
      test('should be instance of MotivationalQuote', () {
        // Assert
        expect(motivationalQuoteModel, isA<MotivationalQuote>());
      });
    });
  });
}
