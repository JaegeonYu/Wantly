import 'package:logger/logger.dart';

/// WANTLY 앱의 로거
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  /// Debug 레벨 로그
  static void d(dynamic message) {
    _logger.d(message);
  }

  /// Info 레벨 로그
  static void i(dynamic message) {
    _logger.i(message);
  }

  /// Warning 레벨 로그
  static void w(dynamic message) {
    _logger.w(message);
  }

  /// Error 레벨 로그
  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
