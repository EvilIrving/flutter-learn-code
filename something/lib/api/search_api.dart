import 'package:dio/dio.dart';
import 'package:something/data/search_data.dart';
import '../request/http_dio.dart';

class SearchApi {
  static Future<List<SearchListItemModel>?> search(String k) async {
    Response response =
        await Request.post('article/query/0/json', queryParameters: {
      'k': k,
    });
    SearchListModel result = SearchListModel.fromJson(response.data);
    return result.datas ?? [];
  }
}
