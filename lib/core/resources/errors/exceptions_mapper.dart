import 'dart:async';

import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

import 'exceptions.dart';

extension ErrorsMapper on Exception {
  Failure get toFailure {
    debugPrint(toString());
    switch (this) {
      case DioException():
        return ServerFailure(message: (this as DioException).message);
      case TimeoutException():
        return TimeOutFailure();
      case ServerException():
        return ServerFailure(message: (this as ServerException).message);
      case AuthException():
        return AuthFailure(message: (this as AuthException).message);
      case sp.AuthSessionMissingException():
        return AuthFailure(message: (this as sp.AuthSessionMissingException).message);
      case sp.AuthException():
        return AuthFailure(message: (this as sp.AuthException).message);
      case FileNotExistsException():
        return FileNotExistsFailure(message: (this as FileNotExistsException).message);
      case ItemNotExistsException():
        return ItemNotExistsFailure(message: (this as ItemNotExistsException).message);
      case QuestionsNotExistsException():
        return QuestionsNotExistsFailure(message: (this as QuestionsNotExistsException).message);
      case CacheEmptyException():
        return CacheFailure(message: (this as CacheEmptyException).message);
      default:
        return AnonFailure(message: toString());
    }
  }
}
