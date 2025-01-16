// ignore_for_file: lines_longer_than_80_chars

import 'package:logger/logger.dart';

/// Initialize here the global [Logger] instance for Kickin.
Logger _kickinLogger =
    Logger(level: Level.debug); // Set to 'debug' or 'info' based on your needs

/// Log error method used for printing out errors in the Kickin app.
void logKickinError(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) =>
    _kickinLogger.e(
      message,
      time: time ?? DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );

/// Log warning used for printing warning messages for Kickin.
void logKickinWarning(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) =>
    _kickinLogger.w(
      message,
      time: time ?? DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );

/// Log informational messages for Kickin.
void logKickinInfo(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) =>
    _kickinLogger.i(
      message,
      time: time ?? DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );

/// Log debug messages for Kickin (useful during development).
void logKickinDebug(
  dynamic message, {
  DateTime? time,
  Object? error,
  StackTrace? stackTrace,
}) =>
    _kickinLogger.d(
      message,
      time: time ?? DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );
