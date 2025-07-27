import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:bac_project/features/tests/data/datasources/tests_remote_data_source_impl.dart';
import 'package:bac_project/features/tests/data/repositories/tests_repository_impl.dart';
import 'package:bac_project/features/tests/domain/usecases/get_questions_use_case.dart';
import 'package:bac_project/features/tests/domain/requests/get_questions_request.dart';

void main() {
  late GetQuestionsUseCase getQuestionsUseCase;
  late TestsRepositoryImpl repository;
  late TestsRemoteDataSourceImpl dataSource;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel('plugins.flutter.io/path_provider').setMockMethodCallHandler((
      MethodCall methodCall,
    ) async {
      return '.';
    });
  });

  setUp(() {
    dataSource = TestsRemoteDataSourceImpl();
    repository = TestsRepositoryImpl(remoteDataSource: dataSource);
    getQuestionsUseCase = GetQuestionsUseCase(repository: repository);
  });

  group('Get Questions Integration Tests', () {
    test('should get questions for lesson 1 successfully', () async {
      // act
      final result = await getQuestionsUseCase.call(const GetQuestionsRequest(lessonId: '1'));

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.questions.length, 3); // Based on the questions.json data
        expect(response.questions.first.lessonId, '1');
        expect(response.questions.first.unitId, '1');
        expect(
          response.questions.first.text,
          'ما هو الجهاز المسؤول عن التنسيق العصبي في جسم الإنسان؟',
        );
      });
    });

    test('should get questions for lesson 2 successfully', () async {
      // act
      final result = await getQuestionsUseCase.call(const GetQuestionsRequest(lessonId: '2'));

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.questions.length, 3); // Based on the questions.json data
        expect(response.questions.first.lessonId, '2');
        expect(response.questions.first.unitId, '1');
      });
    });

    test('should return empty list for non-existent lesson', () async {
      // act
      final result = await getQuestionsUseCase.call(const GetQuestionsRequest(lessonId: '999'));

      // assert
      expect(result.isRight(), true);
      result.fold((failure) => fail('Expected success but got failure: ${failure.message}'), (
        response,
      ) {
        expect(response.questions.length, 0);
      });
    });
  });
}
