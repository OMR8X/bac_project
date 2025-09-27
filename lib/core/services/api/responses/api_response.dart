import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:bac_project/core/resources/errors/exceptions.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:dio/dio.dart';

class ApiResponse {
  //
  final bool? status;
  //
  final int? statusCode;
  //
  final String message;
  // hold incoming data from response
  final dynamic data;
  // hold any errors details
  final Map<String, dynamic>? errors;
  //
  final int? currentPage;
  final int? lastPage;

  ApiResponse({
    this.status,
    this.statusCode,
    this.errors,
    required this.message,
    required this.data,
    this.currentPage,
    this.lastPage,
  });

  factory ApiResponse.empty() {
    return ApiResponse(message: "", data: []);
  }

  void throwErrorIfExists() {
    if (status == true || statusCode == 200) {
      return;
    }
    if (statusCode == 401) {
      throw AuthException(message: message);
    }
    if (status == false || status == null || (errors?.isNotEmpty ?? false)) {
      throw ServerException(message: message);
    }

    throw const ServerException();
  }

  String getMessage() {
    //
    String details = message;
    //
    if (errors != null || errors != {}) {
      //
      details += ' : \n';
      //
      (errors ?? {}).forEach((key, value) {
        details += (value as List).first;
      });
      //
    }
    //
    return details;
  }

  factory ApiResponse.fromDioResponse(Response response) {
    try {
      return ApiResponse(
        data: response.data["data"],
        status: (response.data["status"] as String?) == "success",
        statusCode: response.statusCode,
        errors: response.data["errors"],
        message: response.data["message"] ?? "",
        currentPage: response.data["current_page"] ?? 0,
        lastPage: response.data["last_page"] ?? 0,
      );
    } on Error catch (e) {
      throw e;
    } on Exception catch (e) {
      throw e;
    }
  }
}
