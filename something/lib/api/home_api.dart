import 'package:dio/dio.dart';
import '../request/http_dio.dart';
import '../data/banner_data.dart';
import '../data/articles_data.dart';

class HomeApi {
  static Future<List<BannerItemData?>?> getBanner() async {
    Response response = await Request.get('/banner/json');
    BannerListData bannerListData = BannerListData.fromJson(response.data);
    return bannerListData.bannerList ?? [];
  }

  static Future<List<ArticleItem>> getArticleList(String id) async {
    Response response = await Request.get('/article/list/$id/json');
    ArticleData articles = ArticleData.fromJson(response.data);
    return articles.datas ?? [];
  }

  static Future<List<ArticleItem>> getTopArticleList() async {
    Response response = await Request.get('/article/top/json');
    TopArticleModel articles = TopArticleModel.fromJson(response.data);
    return articles.topList;
  }
}