import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/tests_repository.dart';
import '../requests/get_lessons_request.dart';
import '../../data/responses/get_lessons_response.dart';

class GetLessonsUsecase {
  final TestsRepository repository;

  GetLessonsUsecase({required this.repository});

  Future<Either<Failure, GetLessonsResponse>> call(GetLessonsRequest request) async {
    return await repository.getLessons(request);
  }
}
