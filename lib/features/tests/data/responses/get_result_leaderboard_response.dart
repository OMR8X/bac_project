import '../models/result_model.dart';

class GetResultLeaderboardResponse {
  final List<ResultModel> topResults;

  const GetResultLeaderboardResponse({required this.topResults});

  factory GetResultLeaderboardResponse.fromJson(List<dynamic> json) {
    return GetResultLeaderboardResponse(
      topResults: json.map((e) => ResultModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  String toString() => 'GetResultLeaderboardResponse(topResults: $topResults)';
}
