import 'dart:async';

import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'exceptions.dart';

extension ErrorsMapper on Exception {
  Failure get toFailure {
    debugPrint(toString());
    switch (runtimeType) {
      case DioException():
        return ServerFailure(message: (this as DioException).message);
      case TimeoutException():
        return TimeOutFailure();
      case ServerException():
        return ServerFailure(message: (this as ServerException).message);
      case AuthException():
        return AuthFailure(message: (this as AuthException).message);
      case FileNotExistsException():
        return FileNotExistsFailure(message: (this as FileNotExistsException).message);
      case ItemNotExistsException():
        return ItemNotExistsFailure(message: (this as ItemNotExistsException).message);
      case CacheEmptyException():
        return CacheFailure(message: (this as CacheEmptyException).message);
      default:
        return AnonFailure(message: toString());
    }
  }
}
