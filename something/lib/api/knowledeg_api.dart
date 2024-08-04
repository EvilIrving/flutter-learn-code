import 'package:dio/dio.dart';
import 'package:something/data/knowledeg_data.dart';
import 'package:something/data/knowledeg_tab_child_data.dart';
import 'package:something/request/http_dio.dart';

class KnowledegApi {
  static Future<List<KnowledegList>?>? getKnowledegTree() async {
    Response response = await Request.get('tree/json');
    KnowledegModel knowledeg = KnowledegModel.fromJson(response.data);
    return knowledeg.data ?? [];
  }

  static Future<List<KnowledegTabDetail>?>? getKnowledegTabDetail(
      int pageCount, String cid) async { 
    Response response = await Request.get('article/list/${pageCount.toString()}/json',
        queryParameters: {'cid': cid});
    KnowledegTabResult knowledeg = KnowledegTabResult.fromJson(response.data);
    return knowledeg.datas ?? [];
  }
}
