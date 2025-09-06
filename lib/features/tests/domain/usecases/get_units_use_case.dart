import 'package:dartz/dartz.dart';
import '../../../../core/resources/errors/failures.dart';
import '../repositories/tests_repository.dart';
import '../requests/get_units_request.dart';
import '../../data/responses/get_units_response.dart';

class GetUnitsUsecase {
  final TestsRepository repository;

  GetUnitsUsecase({required this.repository});

  Future<Either<Failure, GetUnitsResponse>> call(GetUnitsRequest request) async {
    return await repository.getUnits(request);
  }
}
