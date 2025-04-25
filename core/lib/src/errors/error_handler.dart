import 'package:core/core.dart';

final class ErrorHandler {
  Never handleError(Object exception) {
    throw _parseError(exception);
  }

  AppException _parseError(Object exception) {
    final AppException appException;

    if (exception is AppException) {
      return exception;
    } else if (exception is FirebaseException) {
      appException = _parseFirebaseException(exception);
    } else {
      appException = AppException.unknown();
    }

    return appException;
  }

  AppException _parseFirebaseException(FirebaseException exception) {
    return AppException(
      type: _mapFirebaseCodeToType(exception.code),
      message: exception.code,
    );
  }

  AppExceptionType _mapFirebaseCodeToType(String code) {
    return switch (code) {
      FirebaseCodeErrorMessage.invalidEmail =>
        AppExceptionType.firebaseAuthCodeError,
      FirebaseCodeErrorMessage.wrongPassword =>
        AppExceptionType.firebaseAuthCodeError,
      FirebaseCodeErrorMessage.invalidCredential =>
        AppExceptionType.firebaseAuthCodeError,
      FirebaseCodeErrorMessage.emailInUse =>
        AppExceptionType.firebaseAuthCodeError,
      FirebaseCodeErrorMessage.userNotFound =>
        AppExceptionType.firebaseAuthCodeError,
      FirebaseCodeErrorMessage.channelCreationFailed =>
        AppExceptionType.notificationError,
      FirebaseCodeErrorMessage.documentNotFound =>
        AppExceptionType.firestoreCodeError,
      FirebaseCodeErrorMessage.unavailable =>
        AppExceptionType.firestoreCodeError,
      FirebaseCodeErrorMessage.permissionDenied =>
        AppExceptionType.permissionDeniedError,
      FirebaseCodeErrorMessage.networkFailed => AppExceptionType.networkError,
      _ => AppExceptionType.unknown,
    };
  }
}
