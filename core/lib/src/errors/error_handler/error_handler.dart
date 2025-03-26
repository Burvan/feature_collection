part of errors;

abstract interface class ErrorHandler<T extends Exception> {
  AppException handle(dynamic error);
}