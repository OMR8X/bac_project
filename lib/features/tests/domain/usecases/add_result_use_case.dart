import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/results_repository.dart';
import '../requests/add_result_request.dart';
import '../../data/responses/add_result_response.dart';

class AddResultUseCase {
  final ResultsRepository repository;

  AddResultUseCase({required this.repository});

  Future<Either<Failure, AddResultResponse>> call(AddResultRequest request) async {
    return await repository.addResult(request);
  }
}
