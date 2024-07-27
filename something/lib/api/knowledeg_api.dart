import 'package:dio/dio.dart';
import 'package:something/data/knowledeg_data.dart';
import 'package:something/request/http_dio.dart';

class KnowledegApi {
  static Future<List<KnowledegList>?>? getKnowledegTree() async {
    Response response = await Request.get('tree/json');
    KnowledegModel knowledeg = KnowledegModel.fromJson(response.data);
    return knowledeg.data ?? [];
  }
}
