import '../models/result_model.dart';

class GetResultsResponse {
  final List<ResultModel> results;

  const GetResultsResponse({required this.results});

  factory GetResultsResponse.fromJson(Map<String, dynamic> json) {
    return GetResultsResponse(
      results:
          (json['results'] as List<dynamic>)
              .map((r) => ResultModel.fromJson(r as Map<String, dynamic>))
              .toList(),
    );
  }

  @override
  String toString() => 'GetResultsResponse(results: $results)';
}
