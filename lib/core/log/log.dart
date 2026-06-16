enum FLogLevel { error, warn, info, debug, trace }

abstract class FLogger {
  void error(dynamic message);
  void warn(dynamic message);
  void info(dynamic message);
  void debug(dynamic message);
  void trace(dynamic message);
}
