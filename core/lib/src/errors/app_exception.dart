import 'package:core/core.dart';

final class AppException implements Exception {
  final AppExceptionType type;
  final String? _message;

  AppException({
    required this.type,
    String? message,
  }) : _message = message;

  const AppException.empty()
      : type = AppExceptionType.unknown,
        _message = '';

  factory AppException.unknown({
    String? message,
  }) {
    return AppException(
      type: AppExceptionType.unknown,
      message: message,
    );
  }

  String toLocalizedText() {
    return switch (type) {
      AppExceptionType.unknown => LocaleKeys.errors_unknown.tr(),
      AppExceptionType.firebaseAuthCodeError => switch (_message) {
          FirebaseCodeErrorMessage.emailInUse =>
            LocaleKeys.errors_emailAlreadyInUse.tr(),
          FirebaseCodeErrorMessage.invalidCredential =>
            LocaleKeys.errors_invalidCredential.tr(),
          FirebaseCodeErrorMessage.invalidEmail =>
            LocaleKeys.errors_invalidEmail.tr(),
          FirebaseCodeErrorMessage.wrongPassword =>
            LocaleKeys.errors_wrongPassword.tr(),
          FirebaseCodeErrorMessage.userNotFound =>
            LocaleKeys.errors_noSuchUser.tr(),
          _ => LocaleKeys.errors_unknown.tr(),
        },
      AppExceptionType.notificationError => switch (_message) {
          FirebaseCodeErrorMessage.channelCreationFailed =>
            LocaleKeys.errors_channelCreationFailed.tr(),
          _ => LocaleKeys.errors_unknown.tr(),
        },
      AppExceptionType.firestoreCodeError => switch (_message) {
          FirebaseCodeErrorMessage.documentNotFound =>
            LocaleKeys.errors_documentNotFound.tr(),
          FirebaseCodeErrorMessage.unavailable =>
            LocaleKeys.errors_firestoreUnavailable.tr(),
          _ => LocaleKeys.errors_unknown.tr(),
        },
      AppExceptionType.networkError => LocaleKeys.errors_noInternet.tr(),
      AppExceptionType.permissionDeniedError =>
        LocaleKeys.errors_permissionDenied.tr(),
      AppExceptionType.emailNotVerified =>
        LocaleKeys.errors_emailNotVerified.tr(),
    };
  }

  @override
  String toString() => '${type.name} : ${_message ?? 'No additional data'}';
}

enum AppExceptionType {
  unknown,
  firebaseAuthCodeError,
  notificationError,
  firestoreCodeError,
  networkError,
  permissionDeniedError,
  emailNotVerified,
}

final class FirebaseCodeErrorMessage {
  static const String invalidEmail = 'invalid-email';
  static const String wrongPassword = 'wrong-password';
  static const String invalidCredential = 'invalid-credential';
  static const String emailInUse = 'email-already-in-use';
  static const String networkFailed = 'network-request-failed';
  static const String userNotFound = 'user-not-found';
  static const String permissionDenied = 'permission-denied';
  static const String channelCreationFailed = 'channel-creation-failed';
  static const String documentNotFound = 'not-found';
  static const String unavailable = 'unavailable';
}
