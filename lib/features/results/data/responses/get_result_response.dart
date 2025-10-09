import 'package:bac_project/core/resources/errors/error_mapper.dart';
import 'package:bac_project/features/results/domain/entities/result.dart';

import '../models/result_model.dart';

class GetResultResponse {
  final Result result;
  final List<Result>? previousResults;

  const GetResultResponse({required this.result, required this.previousResults});

  factory GetResultResponse.fromJson(Map<String, dynamic> json) {
    try {
      return GetResultResponse(
        result: ResultModel.fromJson(json['result']),
        previousResults:
            (json['previous_results'] as List<dynamic>?)
                ?.map((e) => ResultModel.fromJson(e))
                .toList() ??
            [],
      );
    } catch (e) {
      throw errorToFailure(e);
    }
  }

  @override
  String toString() => 'GetResultResponse(result: $result, previousResults: $previousResults)';
}
