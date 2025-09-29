import 'package:bac_project/core/services/logs/logs_holder.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as l;

class Logger {
  static l.Logger logger = l.Logger(printer: CustomPrinter(), level: l.Level.debug);

  static void message(String message, {StackTrace? stackTrace}) {
    if (kReleaseMode) debugPrint(message);
    logger.i(message, stackTrace: stackTrace);
    DebugsHolder().addLogs(l.LogEvent(l.Level.info, message));
  }

  static void debug(String message, {StackTrace? stackTrace}) {
    if (kReleaseMode) debugPrint(message);
    logger.d(message, stackTrace: stackTrace);
    DebugsHolder().addLogs(l.LogEvent(l.Level.debug, message));
  }

  static void error(String message, {StackTrace? stackTrace}) {
    if (kReleaseMode) debugPrint(message);
    logger.e(message, stackTrace: stackTrace);
    DebugsHolder().addLogs(l.LogEvent(l.Level.error, message));
  }

  static void warning(String message, {StackTrace? stackTrace}) {
    if (kReleaseMode) debugPrint(message);
    logger.w(message, stackTrace: stackTrace);
    DebugsHolder().addLogs(l.LogEvent(l.Level.warning, message));
  }

  static void verbose(String message, {StackTrace? stackTrace}) {
    if (kReleaseMode) debugPrint(message);
    logger.t(message, stackTrace: stackTrace);
    DebugsHolder().addLogs(l.LogEvent(l.Level.trace, message));
  }

  static void fatal(String message, {StackTrace? stackTrace}) {
    if (kReleaseMode) debugPrint(message);
    logger.f(message, stackTrace: stackTrace);
    DebugsHolder().addLogs(l.LogEvent(l.Level.fatal, message));
  }
}

class CustomPrinter extends l.LogPrinter {
  @override
  List<String> log(l.LogEvent event) {
    final color = l.PrettyPrinter.defaultLevelColors[event.level]!;
    final emoji = l.PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;
    //
    DebugsHolder().addLogs(event);
    //
    final output = [color('$emoji: $message')];

    // Include stack trace if present
    if (event.stackTrace != null) {
      output.add(event.stackTrace.toString());
    }

    return output;
  }
}
