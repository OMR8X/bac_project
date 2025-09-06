import '../models/result_model.dart';

class AddResultResponse {
  final ResultModel result;

  const AddResultResponse({required this.result});

  factory AddResultResponse.fromJson(Map<String, dynamic> json) {
    return AddResultResponse(result: ResultModel.fromJson(json['data']));
  }
}
