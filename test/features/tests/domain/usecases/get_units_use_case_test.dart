import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/tests/domain/entities/unit.dart' as entities;
import 'package:bac_project/features/tests/domain/repositories/tests_repository.dart';
import 'package:bac_project/features/tests/domain/requests/get_units_request.dart';
import 'package:bac_project/features/tests/data/responses/get_units_response.dart';
import 'package:bac_project/features/tests/domain/usecases/get_units_use_case.dart';

import 'get_units_use_case_test.mocks.dart';

@GenerateMocks([TestsRepository])
void main() {
  late GetUnitsUseCase useCase;
  late MockTestsRepository mockRepository;

  setUp(() {
    mockRepository = MockTestsRepository();
    useCase = GetUnitsUseCase(repository: mockRepository);
  });

  group('GetUnitsUseCase', () {
    const testUnits = [
      entities.Unit(id: '1', title: 'الوحدة الأولى', subtitle: 'مقدمة في الرياضيات'),
      entities.Unit(id: '2', title: 'الوحدة الثانية', subtitle: 'الجبر والهندسة'),
    ];

    const testResponse = GetUnitsResponse(units: testUnits, totalCount: 2);

    test('should return GetUnitsResponse when repository call is successful', () async {
      // arrange
      const request = GetUnitsRequest();
      when(mockRepository.getUnits(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(testResponse));
      verify(mockRepository.getUnits(request));
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return GetUnitsResponse when request has no pagination', () async {
      // arrange
      const request = GetUnitsRequest();
      when(mockRepository.getUnits(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(testResponse));
      verify(mockRepository.getUnits(request));
    });

    test('should return ServerFailure when repository throws ServerException', () async {
      // arrange
      const request = GetUnitsRequest();
      const failure = ServerFailure(message: 'Server error occurred');
      when(mockRepository.getUnits(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getUnits(request));
    });

    test('should return AuthFailure when repository throws AuthException', () async {
      // arrange
      const request = GetUnitsRequest();
      const failure = AuthFailure(message: 'Authentication failed');
      when(mockRepository.getUnits(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getUnits(request));
    });

    test('should return AnonFailure when repository throws unknown exception', () async {
      // arrange
      const request = GetUnitsRequest();
      const failure = AnonFailure(message: 'Unknown error occurred');
      when(mockRepository.getUnits(request)).thenAnswer((_) async => const Left(failure));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Left(failure));
      verify(mockRepository.getUnits(request));
    });

    test('should return empty list when no units available', () async {
      // arrange
      const request = GetUnitsRequest();
      const emptyResponse = GetUnitsResponse(units: [], totalCount: 0);
      when(mockRepository.getUnits(request)).thenAnswer((_) async => const Right(emptyResponse));

      // act
      final result = await useCase.call(request);

      // assert
      expect(result, const Right(emptyResponse));
      verify(mockRepository.getUnits(request));
    });

    test('should pass correct request parameters to repository', () async {
      // arrange
      const request = GetUnitsRequest();
      when(mockRepository.getUnits(request)).thenAnswer((_) async => const Right(testResponse));

      // act
      await useCase.call(request);

      // assert
      verify(mockRepository.getUnits(request));
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
