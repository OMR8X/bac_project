import 'dart:core';

class ServerException implements Exception {
  final String message;
  const ServerException({this.message = ""});
}

class AuthException implements Exception {
  final String message;
  const AuthException({required this.message});
}

class FileNotExistsException implements Exception {
  final String message;
  const FileNotExistsException({this.message = ""});
}

class ItemNotExistsException implements Exception {
  final String message;
  const ItemNotExistsException({this.message = ""});
}
class CacheEmptyException implements Exception {
  final String message;
  const CacheEmptyException({this.message = ""});
}
