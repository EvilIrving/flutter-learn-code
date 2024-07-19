import 'package:dio/dio.dart';
import 'package:something/data/hot_key_data.dart';
import 'package:something/request/http_dio.dart';

class HotKeyApi {
  static Future<List<HotWebItem>?>? getHotWebList() async {
    Response response = await Request.get('/friend/json');
    HotWebModel hotweb = HotWebModel.fromJson(response.data);
    return hotweb.data ?? [];
  }

  static Future<List<HotKeyItem>?>? getHotKeyList() async {
    Response response = await Request.get('/hotkey/json');
    HotKeyModel hotkey = HotKeyModel.fromJson(response.data);
    return hotkey.data ?? [];
  }
}
