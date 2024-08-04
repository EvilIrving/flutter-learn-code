import 'package:dio/dio.dart';
import 'package:something/data/my_collects_data.dart';
import '../request/http_dio.dart';

class PersonalApi {
  static Future<bool> login(String username, String password) async {
    Response response = await Request.post('user/login', queryParameters: {
      'username': username,
      'password': password,
    });

    if (response.data['username'].isNotEmpty) {
      return true;
    }
    return false;
  }

  static Future<bool> logout() async {
    Response response = await Request.get('user/logout/json');
    if (response.data != null && response.data is bool) {
      return true;
    }
    return false;
  }

  static Future<bool> register(
      String username, String password, String repassword) async {
    Response response = await Request.post('user/register', queryParameters: {
      'username': username,
      'password': password,
      'repassword': repassword
    });

    if (response.data['username'].isNotEmpty) {
      return true;
    }
    return false;
  }

  ///取消收藏文章
  static Future<bool> cancelCollect(String id) async {
    Response response = await Request.post("lg/uncollect_originId/$id/json");
    if (response.data != null && response.data == true) {
      return true;
    }
    return false;
  }

  ///获取我的收藏列表
  static Future<List<MyCollectItemModel>?> getMyCollects(
      String pageCount) async {
    Response rsp = await Request.get("lg/collect/list/$pageCount/json");
    MyCollectsModel? model = MyCollectsModel.fromJson(rsp.data);
    if (model.datas != null && model.datas?.isNotEmpty == true) {
      return model.datas;
    }
    return [];
  }
}
