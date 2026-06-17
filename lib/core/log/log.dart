enum FLogLevel { error, warn, info, debug, trace }

abstract class LoggableMetadata {
  String toLogString();
}

abstract class FLogger {
  void error(LoggableMetadata message);
  void warn(LoggableMetadata message);
  void info(LoggableMetadata message);
  void debug(LoggableMetadata message);
  void trace(LoggableMetadata message);
}
