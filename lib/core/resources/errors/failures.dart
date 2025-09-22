import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class QuestionsNotExistsFailure extends Failure {
  static const String _defaultMessage = "لم يتم العثور على اسئلة";

  const QuestionsNotExistsFailure({String? message}) : super(message ?? _defaultMessage);
}

class FileNotExistsFailure extends Failure {
  static const String _defaultMessage = "الملف غير موجود";

  const FileNotExistsFailure({String? message}) : super(message ?? _defaultMessage);
}

class ItemNotExistsFailure extends Failure {
  static const String _defaultMessage = "العنصر غير موجود";

  const ItemNotExistsFailure({String? message}) : super(message ?? _defaultMessage);
}

class CanceledFailure extends Failure {
  static const String _defaultMessage = "تم الغاء العملية";

  const CanceledFailure({String? message}) : super(message ?? _defaultMessage);
}

class UnknownFailure extends Failure {
  static const String _defaultMessage = "حصل خطأ غير معروف";

  const UnknownFailure({String? message}) : super(message ?? _defaultMessage);
}

class CacheFailure extends Failure {
  static const String _defaultMessage = "";

  const CacheFailure({String? message}) : super(message ?? _defaultMessage);
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message ?? "حصل خطأ اثناء الاتصال بالخادم");
}

class TimeOutFailure extends Failure {
  static const String _defaultMessage = "انتهت فترة الاتصال بالخادم";

  const TimeOutFailure() : super(_defaultMessage);
}

class AuthFailure extends Failure {
  static const String _defaultMessage = "حصل خطأ في المصادقة";
  const AuthFailure({String? message}) : super(message ?? _defaultMessage);
}

class NoInternetFailure extends Failure {
  static const String _defaultMessage = "لا يوجد اتصال بالانترنت";

  const NoInternetFailure() : super(_defaultMessage);
}

class ExitFailure extends Failure {
  static const String _defaultMessage = "تم الغاء العملية";

  const ExitFailure() : super(_defaultMessage);
}

class MissingPropertiesFailure extends Failure {
  static const String _defaultMessage = "يرجى ملء جميع الخانات المطلوبة";

  const MissingPropertiesFailure() : super(_defaultMessage);
}
