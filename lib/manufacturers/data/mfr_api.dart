import 'package:dio/dio.dart';

class MfrApi {
  final Dio dio = Dio();
  Future<Response<dynamic>> get({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await dio.get(path, queryParameters: queryParameters);
    return response;
  }
}
