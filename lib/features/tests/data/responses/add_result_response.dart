import 'package:bac_project/core/resources/errors/error_mapper.dart';

import '../models/result_model.dart';

class AddResultResponse {
  final ResultModel result;

  const AddResultResponse({required this.result});

  factory AddResultResponse.fromJson(Map<String, dynamic> json) {
    try {
      return AddResultResponse(result: ResultModel.fromJson(json['result']));
    } catch (e) {
      throw errorToFailure(e);
    }
  }
}
