import 'package:bac_project/core/services/debug/debugging_factory.dart';
import 'package:bac_project/core/services/debug/debugs_holder.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'dart:developer' as developer;

abstract class DebuggingClient {
  void initialize();
  void logMessage(String message);
  void logError(String message);
  void logWarning(String message);
  void logDebug(String message);
  void logVerbose(String message);
}

class LoggerClient implements DebuggingClient {
  late final Logger _logger;

  @override
  initialize() {
    _logger = DebuggingFactory().call();
  }

  @override
  void logMessage(String message) {
    if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(LogEvent(Level.info, message));
    _logger.i(message);
  }

  @override
  void logDebug(String message) {
    if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(LogEvent(Level.debug, message));
    _logger.d(message);
  }

  @override
  void logError(String message) {
    if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(LogEvent(Level.error, message));
    _logger.e(message);
  }

  @override
  void logWarning(String message) {
    if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(LogEvent(Level.warning, message));
    _logger.w(message);
  }

  @override
  void logVerbose(String message) {
    if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(LogEvent(Level.trace, message));
    _logger.t(message);
  }
}
