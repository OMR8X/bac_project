import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/tests_repository.dart';
import '../requests/get_test_options_request.dart';
import '../../data/responses/get_test_options_response.dart';

class GetTestOptionsUseCase {
  final TestsRepository repository;

  GetTestOptionsUseCase({required this.repository});

  Future<Either<Failure, GetTestOptionsResponse>> call(
    GetTestOptionsRequest request,
  ) async {
    return await repository.getTestOptions(request);
  }
}
