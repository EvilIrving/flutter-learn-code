import 'package:dio/dio.dart';
import 'package:something/request/cookies_interceptor.dart';
import 'package:something/request/interceptor.dart';

class Request {
  static const _defaultTimeout = Duration(seconds: 30);
  static final Dio _dio = Dio();
  final CancelToken _cancelToken = CancelToken();

  static void init({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    ResponseType? responseType,
    String? contentType,
  }) {
    _dio.options = BaseOptions(
      baseUrl: baseUrl ?? 'https://wanandroid.com/',
      connectTimeout: connectTimeout ?? _defaultTimeout,
      receiveTimeout: receiveTimeout ?? _defaultTimeout,
      sendTimeout: sendTimeout ?? _defaultTimeout,
      responseType: responseType ?? ResponseType.json,
      contentType: contentType ?? Headers.jsonContentType,
    );

    _dio.interceptors.add(CookiesInterceptor());
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

  static Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await _dio.post(path, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 500,
        data: {'error': e.toString()},
      );
    }
  }

  ///  post
  // Future<Response?> post(String path,
  //     {Map<String, dynamic>? params,
  //     data,
  //     Map<String, dynamic>? headers,
  //     CancelToken? cancelToken,
  //     ProgressCallback? onSendProgress,
  //     ProgressCallback? onReceiveProgress}) async {
  //   _dio.options.headers.addAll(headers ?? {});
  //   _dio.options.responseType = ResponseType.json;

  //   return await _dio.post(
  //     path,
  //     data: data,
  //     queryParameters: params,
  //     cancelToken: cancelToken ?? _cancelToken,
  //     onReceiveProgress: onReceiveProgress,
  //     onSendProgress: onSendProgress,
  //   );
  // }

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

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests({CancelToken? token}) {
    token ?? _cancelToken.cancel("cancelled");
  }
}
