import 'package:dio/dio.dart';
import 'package:something/request/interceptor.dart';

class Request {
  static const _defaultTimeout = Duration(seconds: 30);
  static final Dio _dio = Dio();

  static void init({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl ?? 'https://wanandroid.com',
      connectTimeout: connectTimeout ?? _defaultTimeout,
      receiveTimeout: receiveTimeout ?? _defaultTimeout,
      sendTimeout: sendTimeout ?? _defaultTimeout,
      responseType: responseType ?? ResponseType.json,
      contentType: contentType ?? Headers.jsonContentType,
    );

    // addInterceptor();
    _dio.interceptors.add(ResponseInterceptor());
  }

  static Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
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

  static void addInterceptor() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        print('REQUEST[${options.method}] => HEADERS: ${options.headers}');
        print(
            'REQUEST[${options.method}] => QUERY PARAMETERS: ${options.queryParameters}');
        print('REQUEST[${options.method}] => DATA: ${options.data}');
        handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
        handler.next(response);
      },
      onError: (DioException err, ErrorInterceptorHandler handler) {
        print('错误拦截: $err');
        handler.next(err);
      },
    ));
  }

  static void removeInterceptor() {}
}
