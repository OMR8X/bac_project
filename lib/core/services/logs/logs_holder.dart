import 'package:logger/logger.dart';

class DebugsHolder {
  ///
  // Private constructor for singleton pattern
  DebugsHolder._privateConstructor();

  // The single instance
  static final DebugsHolder _instance = DebugsHolder._privateConstructor();

  // Factory constructor to return the same instance every time
  factory DebugsHolder() => _instance;

  ///
  final List<LogEvent> debugs = List.empty(growable: true);

  ///
  void addLogs(LogEvent event) async {
    debugs.insert(0, event);
  }

  void clearLogs() {
    debugs.clear();
  }
}
