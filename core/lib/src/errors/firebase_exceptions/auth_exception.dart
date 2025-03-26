part of errors;

class AuthException extends AppException {
  const AuthException({
    required String? message,
  }) : super(message: message ?? 'Authentication error');
}
