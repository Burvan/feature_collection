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
          FirebaseCodeErrorMessage.networkFailed =>
            LocaleKeys.errors_noInternet.tr(),
          FirebaseCodeErrorMessage.userNotFound =>
            LocaleKeys.errors_noSuchUser.tr(),
          _ => LocaleKeys.errors_unknown.tr(),
        },
      AppExceptionType.notificationError => switch (_message) {
          FirebaseCodeErrorMessage.channelCreationFailed =>
            LocaleKeys.errors_channelCreationFailed.tr(),
          FirebaseCodeErrorMessage.notificationPermissionDenied =>
            LocaleKeys.errors_notificationPermissionDenied.tr(),
          _ => LocaleKeys.errors_unknown,
        }
    };
  }

  @override
  String toString() => '${type.name} : ${_message ?? 'No additional data'}';
}

enum AppExceptionType {
  unknown,
  firebaseAuthCodeError,
  notificationError,
}

final class FirebaseCodeErrorMessage {
  static const String invalidEmail = 'invalid-email';
  static const String wrongPassword = 'wrong-password';
  static const String invalidCredential = 'invalid-credential';
  static const String emailInUse = 'email-already-in-use';
  static const String networkFailed = 'network-request-failed';
  static const String userNotFound = 'user-not-found';
  static const String notificationPermissionDenied = 'permission-denied';
  static const String channelCreationFailed = 'channel-creation-failed';
}
