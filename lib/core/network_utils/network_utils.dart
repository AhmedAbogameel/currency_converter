import 'package:dio/dio.dart';

abstract class NetworkUtils {
  Future<Response> get(String path, {Map<String, dynamic>? headers});
}