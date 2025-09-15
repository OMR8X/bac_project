import '../models/result_model.dart';

class GetResultResponse {
  final ResultModel result;
  final List<ResultModel>? previousResults;

  const GetResultResponse({required this.result, required this.previousResults});

  factory GetResultResponse.fromJson(Map<String, dynamic> json) {
    return GetResultResponse(
      result: ResultModel.fromJson(json['result']),
      previousResults:
          (json['previous_results'] as List<dynamic>?)
              ?.map((e) => ResultModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  String toString() => 'GetResultResponse(result: $result, previousResults: $previousResults)';
}
