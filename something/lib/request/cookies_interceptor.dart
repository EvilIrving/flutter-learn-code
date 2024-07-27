import 'dart:io';
import 'package:dio/dio.dart';
import 'package:something/service_locator.dart';
import 'package:something/utils/local_storage_service.dart';

class CookiesInterceptor extends Interceptor {
  final LocalStorageService storageService = locator<LocalStorageService>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if (!options.path.contains('user/login') ||
    //     !options.path.contains('user/register')) {
    //   List<String> cookies = storageService.cookies;
    //   print('🍪:$cookies');
    //   options.headers[HttpHeaders.setCookieHeader] = cookies;
    // }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path.contains('user/login')) {
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookies = [];
      if (list is List) {
        for (String item in list) {
          cookies.add(item);
        }
      }
      storageService.cookies = cookies;
    }
    super.onResponse(response, handler);
  }
}
