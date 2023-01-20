import 'package:currency_converter/core/errors/failure.dart';
import 'package:currency_converter/main.dart';
import 'package:flutter/material.dart';

void showSnackBar(String message, {
  bool isError = false,
}) {
  ScaffoldMessenger.of(globalContext).hideCurrentSnackBar();
  ScaffoldMessenger.of(globalContext).showSnackBar(SnackBar(
    content: Text(message),
    backgroundColor: isError ? Colors.red : null,
  ));
}

void showAppFailureSnackBar(Failure failure) {
  String message = 'Unhandled error';
  if (failure is NoInternetFailure) {
    message = 'No internet';
  } else if (failure is TimeoutFailure) {
    message = 'Timeout';
  } else if (failure is ServerFailure) {
    switch (failure.statusCode) {
      case 401:
        message = 'Unauthorized';
        break;
      case 404:
        message = 'Not found';
        break;
      case 429:
        message = 'Too many requests';
        break;
      case 400:
        message = 'Bad Request';
        break;
    }
    if (failure.statusCode! >= 500) {
      message = 'Server Error';
    }
  }
  showSnackBar(message, isError: true);
}