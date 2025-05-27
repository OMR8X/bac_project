import 'package:logger/logger.dart';

import 'debugs_holder.dart';

class DebuggingFactory {
  Logger call() {
    late final Logger logger;
    logger = Logger(
      printer: CustomPrinter(),
      level: Level.debug,
    );
    return logger;
  }
}

class CustomPrinter extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level]!;
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;
    //
    DebugsHolder().addLogs(event);
    //
    return [color('$emoji: $message')];
  }
}
