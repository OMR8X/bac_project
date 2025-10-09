import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/results_repository.dart';
import '../requests/get_result_request.dart';
import '../../data/responses/get_result_response.dart';

class GetResultUsecase {
  final ResultsRepository repository;

  GetResultUsecase({required this.repository});

  Future<Either<Failure, GetResultResponse>> call(GetResultRequest request) async {
    return await repository.getResult(request);
  }
}
