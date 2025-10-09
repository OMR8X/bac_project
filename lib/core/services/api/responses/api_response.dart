import 'package:bac_project/core/resources/errors/exceptions.dart';
import 'package:dio/dio.dart';

class ApiResponse {
  final bool? success;
  final String? message;
  final dynamic data;
  final int? currentPage;
  final int? lastPage;

  ApiResponse({
    this.success,
    required this.message,
    required this.data,
    this.currentPage,
    this.lastPage,
  });

  factory ApiResponse.empty() {
    return ApiResponse(message: "", data: []);
  }

  void throwErrorIfExists() {
    if (success == true) {
      return;
    }
    throw ServerException(message: message);
  }

  factory ApiResponse.fromDioResponse(Response response) {
    try {
      return ApiResponse(
        data: response.data["data"],
        success: response.data["success"] as bool?,
        message: response.data["message"] ?? "",
        currentPage: response.data["current_page"] ?? 0,
        lastPage: response.data["last_page"] ?? 0,
      );
    } on Error catch (e) {
      throw ServerException(message: e.toString());
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
