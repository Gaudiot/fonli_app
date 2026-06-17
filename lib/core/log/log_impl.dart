import 'package:fonli_app/core/log/log.dart';
import 'package:logger/logger.dart';

class LogImpl implements FLogger {
  late final Logger _logger;

  LogImpl({required String name, FLogLevel logLevel = FLogLevel.info}) {
    _logger = Logger();
  }

  @override
  void error(LoggableMetadata message) {
    _logger.e(message.toLogString());
  }

  @override
  void warn(LoggableMetadata message) {
    _logger.w(message.toLogString());
  }

  @override
  void info(LoggableMetadata message) {
    _logger.i(message.toLogString());
  }

  @override
  void debug(LoggableMetadata message) {
    _logger.d(message.toLogString());
  }

  @override
  void trace(LoggableMetadata message) {
    _logger.t(message.toLogString());
  }
}
