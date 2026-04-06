import 'package:logger/logger.dart';

/// Chapter 8: Secure logger that filters PII from output.
class SecureLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, printTime: true),
  );

  static final _piiPatterns = [
    RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'), // email
    RegExp(r'password\s*=\s*\S+', caseSensitive: false), // password
    RegExp(r'token\s*[:=]\s*\S+', caseSensitive: false), // token
    RegExp(r'key\s*[:=]\s*\S+', caseSensitive: false), // API key
  ];

  String _filterPii(String message) {
    var filtered = message;
    for (final pattern in _piiPatterns) {
      filtered = filtered.replaceAll(pattern, '[REDACTED]');
    }
    return filtered;
  }

  void info(String message) => _logger.i(_filterPii(message));
  void warning(String message) => _logger.w(_filterPii(message));
  void error(String message, [Object? error]) =>
      _logger.e(_filterPii(message), error: error);
  void debug(String message) => _logger.d(_filterPii(message));
}
