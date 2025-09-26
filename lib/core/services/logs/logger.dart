import 'package:bac_project/core/services/logs/logs_holder.dart';
import 'package:logger/logger.dart' as l;

class Logger {
  late final l.Logger _logger;

  initialize() {
    late final l.Logger logger;
    logger = l.Logger(printer: CustomPrinter(), level: l.Level.debug);
    _logger = logger;
  }

  void logMessage(String message, {StackTrace? stackTrace}) {
    DebugsHolder().addLogs(l.LogEvent(l.Level.info, message));
    _logger.i(message, stackTrace: stackTrace);
  }

  void logDebug(String message, {StackTrace? stackTrace}) {
    // if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(l.LogEvent(l.Level.debug, message));
    _logger.d(message, stackTrace: stackTrace);
  }

  void logError(String message, {StackTrace? stackTrace}) {
    // if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(l.LogEvent(l.Level.error, message));
    _logger.e(message, stackTrace: stackTrace);
  }

  void logWarning(String message, {StackTrace? stackTrace}) {
    // if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(l.LogEvent(l.Level.warning, message));
    _logger.w(message, stackTrace: stackTrace);
  }

  void logVerbose(String message, {StackTrace? stackTrace}) {
    // if (kReleaseMode) debugPrint(message);
    DebugsHolder().addLogs(l.LogEvent(l.Level.trace, message));
    _logger.t(message, stackTrace: stackTrace);
  }

  void logFatal(String message, {StackTrace? stackTrace}) {
    DebugsHolder().addLogs(l.LogEvent(l.Level.fatal, message));
    _logger.f(message, stackTrace: stackTrace);
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
