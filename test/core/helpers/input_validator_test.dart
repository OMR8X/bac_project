import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/core/helpers/input_validator.dart';

void main() {
  group('InputValidator Tests', () {
    group('notEmptyValidator', () {
      test('should return error message when text is null', () {
        final result = InputValidator.notEmptyValidator(null);
        expect(result, InputValidator.noEmptyFiled);
      });

      test('should return error message when text is empty', () {
        final result = InputValidator.notEmptyValidator('');
        expect(result, InputValidator.noEmptyFiled);
      });

      test('should return null when text is not empty', () {
        final result = InputValidator.notEmptyValidator('Valid text');
        expect(result, isNull);
      });
    });

    group('emailValidator', () {
      test('should return error message when email is invalid', () {
        final result = InputValidator.emailValidator('invalid-email');
        expect(result, 'ادخل بريد إلكتروني صالح');
      });

      test('should return null when email is valid', () {
        final result = InputValidator.emailValidator('test@example.com');
        expect(result, isNull);
      });
    });

    group('passwordValidator', () {
      test('should return error message when password is less than 8 characters', () {
        final result = InputValidator.passwordValidator('1234567');
        expect(result, "الرمز السري يجب أن يتالف من 8 أحرف او أكثر");
      });

      test('should return null when password is 8 characters or more', () {
        final result = InputValidator.passwordValidator('password123');
        expect(result, isNull);
      });
    });

    group('phoneValidator', () {
      test('should return error message when phone is not 10 digits', () {
        final result = InputValidator.phoneValidator('123456789');
        expect(result, 'ادخل رقم هاتف صالح');
      });

      test('should return error message when phone contains non-numeric characters', () {
        final result = InputValidator.phoneValidator('051234567a');
        expect(result, 'ادخل رقم هاتف صالح');
      });

      test('should return null when phone is exactly 10 digits', () {
        final result = InputValidator.phoneValidator('0512345678');
        expect(result, isNull);
      });
    });
  });
}
