part of errors;

class UnknownException extends AppException {
  const UnknownException() : super(message: 'An unknown error has occurred');
}