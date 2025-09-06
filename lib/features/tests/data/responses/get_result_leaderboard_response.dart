import '../models/result_model.dart';

class GetResultLeaderboardResponse {
  final List<ResultModel> topResults;

  const GetResultLeaderboardResponse({required this.topResults});

  factory GetResultLeaderboardResponse.fromJson(Map<String, dynamic> json) {
    return GetResultLeaderboardResponse(
      topResults:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          <ResultModel>[],
    );
  }

  @override
  String toString() => 'GetResultLeaderboardResponse(topResults: $topResults)';
}
