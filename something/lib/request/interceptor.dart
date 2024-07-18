import 'package:dio/dio.dart';
import 'package:oktoast/oktoast.dart';
import 'package:something/model/response_model.dart';

class ResponseInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 401) {
      // 处理登录失效的情况,跳转到登录页面
    }

    if (response.statusCode! > 400) {
      // 处理服务器返回的错误信息,弹出toast提示
      showToast(response.data['message'] ?? '服务器错误');
    }

    if (response.statusCode == 200) {
      // 处理服务器返回的数据,根据业务需求进行处理
      var result = ResponseModel.fromJson(response.data);
      try {
        if (result.errorCode == 0) {
          handler.next(Response(
              requestOptions: response.requestOptions, data: result.data));
        } else if (result.errorCode == 10001) {
          // 登录失效
        } else {
          // some other
        }
      } catch (e) {
        handler.reject(
            DioException(requestOptions: response.requestOptions, error: e));
      }
    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.type == DioExceptionType.connectionTimeout) {
      showToast('网络连接超时');
    } else if (err.type == DioExceptionType.receiveTimeout) {
      showToast('数据接收超时');
    } else if (err.type == DioExceptionType.sendTimeout) {
      showToast('数据发送超时');
    } else if (err.type == DioExceptionType.badResponse) {
      showToast(err.response?.data['message'] ?? '服务器错误');
    } else if (err.type == DioExceptionType.cancel) {
      showToast('请求被取消');
    } else {
      showToast('网络异常');
    }
    super.onError(err, handler);
  }
}
