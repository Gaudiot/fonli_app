import 'package:fonli_app/core/log/log.dart';
import 'package:logger/logger.dart';

class LogImpl implements FLogger {
  late final Logger _logger;

  LogImpl({required String name, FLogLevel logLevel = FLogLevel.info}) {
    _logger = Logger();
  }

  @override
  void error(dynamic message) {
    _logger.e(message.toString());
  }

  @override
  void warn(dynamic message) {
    _logger.w(message.toString());
  }

  @override
  void info(dynamic message) {
    _logger.i(message.toString());
  }

  @override
  void debug(dynamic message) {
    _logger.d(message.toString());
  }

  @override
  void trace(dynamic message) {
    _logger.t(message.toString());
  }
}
