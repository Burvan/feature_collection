part of errors;

class InvalidCredentialsException extends AppException {
  const InvalidCredentialsException()
      : super(message: 'Invalid email or password');
}
