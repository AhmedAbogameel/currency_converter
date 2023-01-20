import 'failure.dart';

abstract class AppException implements Exception {
  Failure get toFailure;
}

class ServerException implements AppException {
  final String? message;
  final int? statusCode;

  ServerException({this.message, this.statusCode});

  @override
  ServerFailure get toFailure {
    return ServerFailure.fromException(this);
  }
}

class NoInternetException implements AppException {
  @override
  NoInternetFailure get toFailure {
    return NoInternetFailure();
  }
}

class TimeoutServerException implements AppException {
  @override
  TimeoutFailure get toFailure {
    return TimeoutFailure();
  }
}