part of errors;

class NetworkException extends AppException {
  const NetworkException()
      : super(message: 'No internet connection');
}