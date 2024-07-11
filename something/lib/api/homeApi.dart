import 'package:dio/dio.dart';
import '../request/http.dart';
import '../data/BannerData.dart';
import '../data/ArticlesData.dart';

class HomeApi {
  static Future<List<BannerListData>?> getBanner() async {
    Response response = await Request.get('/banner/json');
    BannerData bannerData = BannerData.fromJson(response.data);
    return bannerData.data ?? [];
  }

  static Future<Object> getArticleList(id) async {
    Response response = await Request.get('article/list/$id/json');
    ArticleData articles = ArticleData.fromJson(response.data);
    return articles.data ?? {};
  }
}
