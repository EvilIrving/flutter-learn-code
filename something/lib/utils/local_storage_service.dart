import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  String? get userName => _getFromDisk('userName');
  set userName(String? value) => _saveToDisk('userName', value);

  List<String> get cookies => _getFromDisk('cookies');
  set cookies(List<String> value) => _saveToDisk('cookies', value);

  // bool? get isFCMPermissionRequested =>
  //     _getFromDisk('isFCMPermissionRequested');
  // set isFCMPermissionRequested(bool? value) =>
  //     _saveToDisk('isFCMPermissionRequested', value);

  // Map<String, dynamic> get tutorials => _getFromDisk('tutorials');
  // set tutorials(Map<String, dynamic> value) => _saveToDisk('tutorials', value);

  dynamic _getFromDisk(String key) {
    Object? value = _preferences?.get(key);
    if (value is String && value.indexOf('{') == 0) {
      value = json.decode(value);
    }
    // print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  // updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content) {
    if (content == null) {
      _preferences?.remove(key);
    }
    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
    if (content is Map<String, List<String>>) {
      _preferences?.setString(key, json.encode(content));
    }
  }

   ///删除key
  Future<bool> remove(String key) async{
   return await _preferences?.remove(key) ?? false;
  }

  ///清空
  Future<bool> clear() async{
    return await _preferences?.clear() ?? false;
  }
}
