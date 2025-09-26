import 'package:bac_project/core/injector/tests_feature_inj.dart';
import 'package:bac_project/core/resources/errors/exceptions.dart';
import 'package:bac_project/core/services/logs/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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

  static Map parseData({dynamic data}) {
    try {
      if (data is String) {
        sl<Logger>().logWarning("API responded with string: ${data}");
        return {};
      }
      if (data["data"] != null) {
        return data["data"];
      }
    } catch (e) {
      sl<Logger>().logWarning("API error type: ${e.runtimeType}");
      return data;
    }
    return data;
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
    final data = parseData(data: response.data);
    return ApiResponse(
      data: data,
      status: (response.data["status"] as String?) == "success",
      statusCode: response.statusCode,
      errors: response.data["errors"],
      message: response.data["message"] ?? "",
      currentPage: response.data["current_page"] ?? 0,
      lastPage: response.data["last_page"] ?? 0,
    );
  }
}
