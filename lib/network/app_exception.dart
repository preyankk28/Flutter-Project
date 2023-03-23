class AppException implements Exception {
  final String? message;
  final String? prefix;

  AppException([this.message, this.prefix]);
  String toString() => '$prefix$message';
}



class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message, 'Unable to process');
}

class ApiNotRespondingException extends AppException {
  ApiNotRespondingException([String? message]) : super(message, 'Api not responded in time');
}

class InvalidRequestException extends AppException {
  InvalidRequestException([String? message]) : super(message, "");
}
