part of errors;

class EmailAlreadyInUseException extends AppException {
  const EmailAlreadyInUseException()
      : super(message: 'Email is already in use');
}