import 'package:dio/dio.dart';

class Request {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://wanandroid.com',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  static Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      print(response);
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 500,
        data: {'error': e.toString()},
      );
    }
  }

  static Future<Response> post(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 500,
        data: {'error': e.toString()},
      );
    }
  }

  static Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 500,
        data: {'error': e.toString()},
      );
    }
  }

  static Future<Response> delete(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 500,
        data: {'error': e.toString()},
      );
    }
  }

  // static void addInterceptor() {
  //   _dio.interceptors.add(InterceptorsWrapper(
  //     onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
  //       print('REQUEST[${options.method}] => PATH: ${options.path}');
  //       print('REQUEST[${options.method}] => HEADERS: ${options.headers}');
  //       print(
  //           'REQUEST[${options.method}] => QUERY PARAMETERS: ${options.queryParameters}');
  //       print('REQUEST[${options.method}] => DATA: ${options.data}');
  //       handler.next(options);
  //     },
  //     onResponse: (Response response, ResponseInterceptorHandler handler) {
  //       print(
  //           'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
  //       print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
  //       handler.next(response);
  //     },
  //     onError: (DioError e, ErrorInterceptorHandler handler) {
  //       print(
  //           'ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
  //       print('ERROR[${e.response?.statusCode}] => DATA: ${e.response?.data}');
  //       handler.next(e);
  //     },
  //   ));
  // }
}
