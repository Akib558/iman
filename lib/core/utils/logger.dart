import 'dart:developer' as developer;

class Logger {
  Logger._();

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'DEBUG',
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(String message) {
    developer.log(message, name: 'INFO');
  }

  static void warning(String message, [Object? error]) {
    developer.log(message, name: 'WARNING', error: error);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    developer.log(
      message,
      name: 'ERROR',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
