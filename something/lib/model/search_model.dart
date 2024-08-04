import 'package:flutter/material.dart';
import 'package:something/api/search_api.dart';
import 'package:something/data/search_data.dart';

class SearchModel extends ChangeNotifier {
  List<SearchListItemModel>? searchResult = [];

  Future searchBy(String k) async {
    searchResult = await SearchApi.search(k);
    notifyListeners();
  }

  void clear() {
    searchResult?.clear();
    notifyListeners();
  }
}
