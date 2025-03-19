import 'package:logger/logger.dart';

class AppLogger {
  final Logger _logger;

  AppLogger() : _logger = Logger();

  void debug(String message) {
    _logger.d(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void error(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    _logger.e(
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
