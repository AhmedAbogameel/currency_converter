import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import 'network_utils.dart';

class DioUtils implements NetworkUtils {

  late Dio dio;

  DioUtils() {
    this.dio = Dio();
    dio.options.validateStatus = (status) => true;
  }

  @override
  Future<Response> get(String path, {Map<String, dynamic>? headers}) async {
    try {
      dio.options.headers = headers;
      final response = await dio.get(path);
      dio.options.headers = null;
      return response;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw NoInternetException();
      }
    } on TimeoutException {
      throw TimeoutServerException();
    } catch (e) {
      rethrow;
    }
    throw UnimplementedError();
  }

}

/*
(Flags, Currencies, Codes, names)
https://restcountries.com/v3.1/all

(Convert API)
https://api.apilayer.com/exchangerates_data/convert?to=egp&from=usd&amount=30
 */