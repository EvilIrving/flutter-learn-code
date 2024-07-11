import 'package:flutter/material.dart';
import '../api/homeApi.dart';
import '../data/BannerData.dart';

class BannerModel extends ChangeNotifier {
  List<BannerListData>? bannerList;

  BannerModel() {
    getBannerData();
  }

  Future<void> getBannerData() async {
    bannerList = await HomeApi.getBanner();
    notifyListeners();
  }
}
