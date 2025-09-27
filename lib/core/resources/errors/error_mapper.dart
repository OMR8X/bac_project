import 'dart:async';

import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

import 'exceptions.dart';

Failure errorToFailure(dynamic error) {
  switch (error) {
    case DioException():
      return ServerFailure(message: (error).message);
    case TimeoutException():
      return TimeOutFailure();
    case ServerException():
      return ServerFailure(message: (error).message);
    case AuthException():
      return AuthFailure(message: (error).message);
    case sp.AuthSessionMissingException():
      return AuthFailure(message: (error).message);
    case sp.AuthException():
      return AuthFailure(message: (error).message);
    case FileNotExistsException():
      return FileNotExistsFailure(message: (error).message);
    case ItemNotExistsException():
      return ItemNotExistsFailure(message: (error).message);
    case QuestionsNotExistsException():
      return QuestionsNotExistsFailure(message: (error).message);
    case CacheEmptyException():
      return CacheFailure(message: (error).message);
    case FirebaseException():
      return ServerFailure(message: (error).message);
    default:
      return UnknownFailure(message: error.toString());
  }
}
