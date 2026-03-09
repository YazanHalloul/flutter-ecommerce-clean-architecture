import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com",
    ),
  );

  Future<Response> get(String url) async {
    return await _dio.get(url);
  }
}
