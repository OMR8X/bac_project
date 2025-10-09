import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  Dio call() {
    //
    final Dio dio = Dio();
    //
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: false,
          requestHeader: true,
          responseBody: false,
          responseHeader: false,
          filter: (options, args) {
            // Only log when there's an error (4xx or 5xx status codes)
            if (args is Response) {
              return (args as Response).statusCode != null && (args as Response).statusCode! >= 400;
            }
            return false;
          },
          enabled: true,
        ),
      );
    }
    //
    return dio;
  }
}
