import 'package:flutter/widgets.dart';
import 'package:something/api/hot_key_api.dart';
import 'package:something/data/hot_key_data.dart';

class HotPageModel extends ChangeNotifier {
  List<HotWebItem>? hotWebItems = [];
  List<HotKeyItem>? hotKeyItems = [];

  HotPageModel() {
    initData();
  }

  Future initData() async {
    hotWebItems = await getHotWebList();
    hotKeyItems = await getHotKeyList();
    notifyListeners();
  }

  Future<List<HotWebItem>?> getHotWebList() async {
    List<HotWebItem>? hotWebList = await HotKeyApi.getHotWebList();
    return hotWebList ?? [];
  }

  Future<List<HotKeyItem>?> getHotKeyList() async {
    List<HotKeyItem>? hotKeyList = await HotKeyApi.getHotKeyList();
    return hotKeyList ?? [];
  }
}
