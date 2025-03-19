import 'package:core/local_logging/app_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class CoreModule {
  @singleton
  Logger get logger => Logger();

  @singleton
  AppLogger appLogger(Logger logger) => AppLogger();
}