import 'package:flutter_test/flutter_test.dart';
import 'package:bac_project/features/auth/data/models/user_data_model.dart';
import 'package:bac_project/features/auth/data/mappers/user_data_mapper.dart';
import 'package:bac_project/features/auth/domain/entites/user_data.dart';

void main() {
  group('UserDataMapper', () {
    late UserData userDataEntity;
    late UserDataModel userDataModel;

    setUp(() {
      userDataEntity = UserData(
        uuid: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        sectionId: '1',
        governorateId: '2',
      );

      userDataModel = UserDataModel(
        uuid: 'user123',
        name: 'Test User',
        email: 'test@example.com',
        sectionId: '1',
        governorateId: '2',
      );
    });

    group('UserDataMapper.toModel', () {
      test('should convert UserData entity to UserDataModel', () {
        // Act
        final result = userDataEntity.toModel;

        // Assert
        expect(result, isA<UserDataModel>());
        expect(result.uuid, equals(userDataEntity.uuid));
        expect(result.name, equals(userDataEntity.name));
        expect(result.email, equals(userDataEntity.email));
        expect(result.sectionId, equals(userDataEntity.sectionId));
        expect(result.governorateId, equals(userDataEntity.governorateId));
      });

      test('should handle empty strings', () {
        // Arrange
        final entity = UserData(uuid: '', name: '', email: '', sectionId: '', governorateId: '');

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.uuid, equals(''));
        expect(result.name, equals(''));
        expect(result.email, equals(''));
        expect(result.sectionId, equals(''));
        expect(result.governorateId, equals(''));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = userDataEntity.toModel;

        // Assert
        expect(result.uuid, equals('user123'));
        expect(result.name, equals('Test User'));
        expect(result.email, equals('test@example.com'));
        expect(result.sectionId, equals('1'));
        expect(result.governorateId, equals('2'));
      });

      test('should handle special characters in strings', () {
        // Arrange
        final entity = UserData(
          uuid: 'user@#\$%',
          name: 'User with Special Chars: @#\$%^&*()',
          email: 'user+test@example.com',
          sectionId: 'section-123',
          governorateId: 'gov_456',
        );

        // Act
        final result = entity.toModel;

        // Assert
        expect(result.uuid, equals('user@#\$%'));
        expect(result.name, equals('User with Special Chars: @#\$%^&*()'));
        expect(result.email, equals('user+test@example.com'));
        expect(result.sectionId, equals('section-123'));
        expect(result.governorateId, equals('gov_456'));
      });
    });

    group('UserDataModelMapper.toEntity', () {
      test('should convert UserDataModel to UserData entity', () {
        // Act
        final result = userDataModel.toEntity;

        // Assert
        expect(result, isA<UserData>());
        expect(result.uuid, equals(userDataModel.uuid));
        expect(result.name, equals(userDataModel.name));
        expect(result.email, equals(userDataModel.email));
        expect(result.sectionId, equals(userDataModel.sectionId));
        expect(result.governorateId, equals(userDataModel.governorateId));
      });

      test('should handle empty strings', () {
        // Arrange
        final model = UserDataModel(
          uuid: '',
          name: '',
          email: '',
          sectionId: '',
          governorateId: '',
        );

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.uuid, equals(''));
        expect(result.name, equals(''));
        expect(result.email, equals(''));
        expect(result.sectionId, equals(''));
        expect(result.governorateId, equals(''));
      });

      test('should preserve all properties correctly', () {
        // Act
        final result = userDataModel.toEntity;

        // Assert
        expect(result.uuid, equals('user123'));
        expect(result.name, equals('Test User'));
        expect(result.email, equals('test@example.com'));
        expect(result.sectionId, equals('1'));
        expect(result.governorateId, equals('2'));
      });

      test('should handle special characters in strings', () {
        // Arrange
        final model = UserDataModel(
          uuid: 'user@#\$%',
          name: 'User with Special Chars: @#\$%^&*()',
          email: 'user+test@example.com',
          sectionId: 'section-123',
          governorateId: 'gov_456',
        );

        // Act
        final result = model.toEntity;

        // Assert
        expect(result.uuid, equals('user@#\$%'));
        expect(result.name, equals('User with Special Chars: @#\$%^&*()'));
        expect(result.email, equals('user+test@example.com'));
        expect(result.sectionId, equals('section-123'));
        expect(result.governorateId, equals('gov_456'));
      });
    });

    group('round-trip conversion', () {
      test('should maintain data integrity through entity -> model -> entity conversion', () {
        // Act
        final model = userDataEntity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.uuid, equals(userDataEntity.uuid));
        expect(backToEntity.name, equals(userDataEntity.name));
        expect(backToEntity.email, equals(userDataEntity.email));
        expect(backToEntity.sectionId, equals(userDataEntity.sectionId));
        expect(backToEntity.governorateId, equals(userDataEntity.governorateId));
      });

      test('should maintain data integrity through model -> entity -> model conversion', () {
        // Act
        final entity = userDataModel.toEntity;
        final backToModel = entity.toModel;

        // Assert
        expect(backToModel.uuid, equals(userDataModel.uuid));
        expect(backToModel.name, equals(userDataModel.name));
        expect(backToModel.email, equals(userDataModel.email));
        expect(backToModel.sectionId, equals(userDataModel.sectionId));
        expect(backToModel.governorateId, equals(userDataModel.governorateId));
      });

      test('should handle empty strings in round-trip conversion', () {
        // Arrange
        final entity = UserData(uuid: '', name: '', email: '', sectionId: '', governorateId: '');

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.uuid, equals(''));
        expect(backToEntity.name, equals(''));
        expect(backToEntity.email, equals(''));
        expect(backToEntity.sectionId, equals(''));
        expect(backToEntity.governorateId, equals(''));
      });

      test('should handle special characters in round-trip conversion', () {
        // Arrange
        final entity = UserData(
          uuid: 'user@#\$%',
          name: 'User with Special Chars: @#\$%^&*()',
          email: 'user+test@example.com',
          sectionId: 'section-123',
          governorateId: 'gov_456',
        );

        // Act
        final model = entity.toModel;
        final backToEntity = model.toEntity;

        // Assert
        expect(backToEntity.uuid, equals('user@#\$%'));
        expect(backToEntity.name, equals('User with Special Chars: @#\$%^&*()'));
        expect(backToEntity.email, equals('user+test@example.com'));
        expect(backToEntity.sectionId, equals('section-123'));
        expect(backToEntity.governorateId, equals('gov_456'));
      });
    });
  });
}
