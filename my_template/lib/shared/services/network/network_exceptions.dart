class TimeoutException implements Exception {
  TimeoutException(this.message);
  final String message;
}

class HttpException implements Exception {
  HttpException(this.message);
  final String message;
}

class CancelException implements Exception {
  CancelException(this.message);
  final String message;
}

class NetworkException implements Exception {
  NetworkException(this.message);
  final String message;
}
