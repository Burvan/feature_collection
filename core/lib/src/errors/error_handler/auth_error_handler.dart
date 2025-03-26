part of errors;

class AuthErrorHandler implements ErrorHandler<Exception> {
  @override
  AppException handle(dynamic error) {
    if (error is FirebaseAuthException) {
      return _handleFirebaseError(error);
    }
    return const UnknownException();
  }

  AppException _handleFirebaseError(FirebaseAuthException e) {
    return switch (e.code) {
      'invalid-email' || 'wrong-password' => const InvalidCredentialsException(),
      'email-already-in-use' => const EmailAlreadyInUseException(),
      'network-request-failed' => const NetworkException(),
      _ => AuthException(message: e.message),
    };
  }
  
}