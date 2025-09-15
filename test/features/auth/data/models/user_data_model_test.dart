import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/auth/data/models/user_data_model.dart';
import 'package:bac_project/features/auth/domain/entites/user_data.dart';

void main() {
  group('UserDataModel', () {
    late UserDataModel userDataModel;

    setUp(() {
      userDataModel = UserDataModel(
        uuid: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        sectionId: '1',
        governorateId: '2',
      );
    });

    group('fromJson', () {
      test('should create UserDataModel from valid JSON', () {
        // Arrange
        final json = {
          'uuid': 'user123',
          'name': 'Test User',
          'email': 'test@example.com',
          'section_id': '1',
          'governorate_id': '2',
        };

        // Act
        final result = UserDataModel.fromJson(json);

        // Assert
        expect(result.uuid, equals('user123'));
        expect(result.name, equals('Test User'));
        expect(result.email, equals('test@example.com'));
        expect(result.sectionId, equals('1'));
        expect(result.governorateId, equals('2'));
      });

      test('should handle numeric IDs converted to strings', () {
        // Arrange
        final json = {
          'uuid': 'user456',
          'name': 'Another User',
          'email': 'another@example.com',
          'section_id': 3,
          'governorate_id': 4,
        };

        // Act
        final result = UserDataModel.fromJson(json);

        // Assert
        expect(result.uuid, equals('user456'));
        expect(result.name, equals('Another User'));
        expect(result.email, equals('another@example.com'));
        expect(result.sectionId, equals('3'));
        expect(result.governorateId, equals('4'));
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {'uuid': '', 'name': '', 'email': '', 'section_id': '', 'governorate_id': ''};

        // Act
        final result = UserDataModel.fromJson(json);

        // Assert
        expect(result.uuid, equals(''));
        expect(result.name, equals(''));
        expect(result.email, equals(''));
        expect(result.sectionId, equals(''));
        expect(result.governorateId, equals(''));
      });
    });

    group('fromEntity', () {
      test('should create UserDataModel from UserData entity', () {
        // Arrange
        final userData = UserData(
          uuid: 'entity123',
          name: 'Entity User',
          email: 'entity@example.com',
          sectionId: '5',
          governorateId: '6',
        );

        // Act
        final result = UserDataModel.fromEntity(userData);

        // Assert
        expect(result, isA<UserDataModel>());
        expect(result.uuid, equals('entity123'));
        expect(result.name, equals('Entity User'));
        expect(result.email, equals('entity@example.com'));
        expect(result.sectionId, equals('5'));
        expect(result.governorateId, equals('6'));
      });

      test('should preserve all properties from entity', () {
        // Arrange
        final userData = UserData(
          uuid: 'preserve123',
          name: 'Preserve User',
          email: 'preserve@example.com',
          sectionId: '7',
          governorateId: '8',
        );

        // Act
        final result = UserDataModel.fromEntity(userData);

        // Assert
        expect(result.uuid, equals(userData.uuid));
        expect(result.name, equals(userData.name));
        expect(result.email, equals(userData.email));
        expect(result.sectionId, equals(userData.sectionId));
        expect(result.governorateId, equals(userData.governorateId));
      });
    });

    group('toJson', () {
      test('should convert UserDataModel to JSON', () {
        // Act
        final result = userDataModel.toJson();

        // Assert
        expect(result['uuid'], equals('user123'));
        expect(result['name'], equals('Test User'));
        expect(result['email'], equals('test@example.com'));
        expect(result['section_id'], equals('1'));
        expect(result['governorate_id'], equals('2'));
      });

      test('should convert different UserDataModel to JSON', () {
        // Arrange
        final model = UserDataModel(
          uuid: 'different123',
          name: 'Different User',
          email: 'different@example.com',
          sectionId: '9',
          governorateId: '10',
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['uuid'], equals('different123'));
        expect(result['name'], equals('Different User'));
        expect(result['email'], equals('different@example.com'));
        expect(result['section_id'], equals('9'));
        expect(result['governorate_id'], equals('10'));
      });

      test('should handle empty strings in JSON', () {
        // Arrange
        final model = UserDataModel(
          uuid: '',
          name: '',
          email: '',
          sectionId: '',
          governorateId: '',
        );

        // Act
        final result = model.toJson();

        // Assert
        expect(result['uuid'], equals(''));
        expect(result['name'], equals(''));
        expect(result['email'], equals(''));
        expect(result['section_id'], equals(''));
        expect(result['governorate_id'], equals(''));
      });
    });

    group('inheritance', () {
      test('should be instance of UserData', () {
        // Assert
        expect(userDataModel, isA<UserData>());
      });
    });

    group('properties', () {
      test('should have correct property values', () {
        // Assert
        expect(userDataModel.uuid, equals('user123'));
        expect(userDataModel.name, equals('Test User'));
        expect(userDataModel.email, equals('test@example.com'));
        expect(userDataModel.sectionId, equals('1'));
        expect(userDataModel.governorateId, equals('2'));
      });
    });
  });
}
