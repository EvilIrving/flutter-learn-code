import 'package:dio/dio.dart';
import '../request/http_dio.dart';

class PersonalApi {
  static Future<bool> login(
      String username, String password) async {
    Response response = await Request.post('user/login', queryParameters: {
      'username': username,
      'password': password, 
    }); 

    if(response.data['username'].isNotEmpty){
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

    if(response.data['username'].isNotEmpty){
      return true;
    }
    return false;
  }
}
