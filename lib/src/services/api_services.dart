import 'dart:developer';

import 'package:dio/dio.dart';

class ApiServices {
  final _dio = Dio();
  Future<Response> getDynamic({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(
          followRedirects: false,
          // will not throw errors
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      return response;
    } catch (e) {
      log(e.toString());
      throw ('Something went wrong');
    }
  }
}
