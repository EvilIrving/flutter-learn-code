import 'package:flutter/material.dart';
import '../api/home_api.dart';
import '../data/banner_data.dart';
import '../data/articles_data.dart';

class BannerModel extends ChangeNotifier {
  List<BannerItemData?>? bannerList;

  BannerModel() {
    getBannerData();
  }
  Future<void> getBannerData() async {
    bannerList = await HomeApi.getBanner();
    notifyListeners();
  }
}

class ArticleModel extends ChangeNotifier {
  List<ArticleItem> articleList = [];
  int page = 1;

  ArticleModel() {
    initArticleModel(false);
  }

  initArticleModel(bool loadMore) async {
    if (loadMore) {
      page++;
    } else {
      page = 1;
      articleList.clear();
    }

    // get top article data first
    List<ArticleItem> topList = await getTopArticleData(loadMore);
    articleList.addAll(topList);

    // get other article data
    List<ArticleItem> otherList = await getArticleData(loadMore);
    articleList.addAll(otherList);

    // refresh page count
    notifyListeners();
  }

  Future<List<ArticleItem>> getArticleData(bool loadMore) async {
    List<ArticleItem> list = await HomeApi.getArticleList('$page');
    if (list.isNotEmpty) {
      return list;
    } else {
      // no more data
      if (loadMore && page > 0) {
        page--;
      }
      return [];
    }
  }

  Future<List<ArticleItem>> getTopArticleData(bool loadMore) async {
    // first load page , need to get data from server
    // not first load page,no need to get data
    List<ArticleItem> list = loadMore ? [] : await HomeApi.getTopArticleList();
    return list;
  }

  Future<void> setCollect(String? id, int index) async {
    bool success = await HomeApi.collect('$id');
    articleList[index].collect = success;
    notifyListeners();
  }

  Future<void> cancelCollect(String? id, int index) async {
    bool success = await HomeApi.unCollect('$id');
    articleList[index].collect = !success;
    notifyListeners();
  }
}
