import 'package:equatable/equatable.dart';

/// Entity representing an exception report.
class ExceptionReport extends Equatable {
  final int id;
  final String exceptionType;
  final String message;
  final String? stackTrace;
  final String? trigger;
  final String? appVersion;
  final String? platform;
  final String? deviceModel;
  final String? userId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ExceptionReport({
    required this.id,
    required this.exceptionType,
    required this.message,
    this.stackTrace,
    this.trigger,
    this.appVersion,
    this.platform,
    this.deviceModel,
    this.userId,
    required this.createdAt,
    this.updatedAt,
  });

  factory ExceptionReport.empty() {
    return ExceptionReport(
      id: 0,
      exceptionType: '',
      message: '',
      createdAt: DateTime.now(),
    );
  }

  ExceptionReport copyWith({
    int? id,
    String? exceptionType,
    String? message,
    String? stackTrace,
    String? trigger,
    String? appVersion,
    String? platform,
    String? deviceModel,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExceptionReport(
      id: id ?? this.id,
      exceptionType: exceptionType ?? this.exceptionType,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
      trigger: trigger ?? this.trigger,
      appVersion: appVersion ?? this.appVersion,
      platform: platform ?? this.platform,
      deviceModel: deviceModel ?? this.deviceModel,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    exceptionType,
    message,
    stackTrace,
    trigger,
    appVersion,
    platform,
    deviceModel,
    userId,
    createdAt,
    updatedAt,
  ];
}
