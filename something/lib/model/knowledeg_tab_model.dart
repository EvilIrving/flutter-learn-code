import 'package:flutter/material.dart';
import 'package:something/api/knowledeg_api.dart';
import 'package:something/data/knowledeg_data.dart';
import 'package:something/data/knowledeg_tab_child_data.dart';

class KnowledegTabModel extends ChangeNotifier {
  List<Tab> tabs = [];
  List<KnowledegTabDetail> detailList = [];
  int _pageCount = 0;

  void initTabs(List<KnowledegChildren>? tabList) {
    if (tabList == null) {
      tabs = [];
    } else {
      for (var ele in tabList) {
        tabs.add(Tab(text: ele.name));
      }
    }
  }

  Future getTabDetail(String cid, bool loadMore) async {
    if (loadMore) {
      _pageCount++;
    } else {
      _pageCount = 0;
      detailList.clear();
    }

    var list = await KnowledegApi.getKnowledegTabDetail(_pageCount, cid);
    if (list?.isNotEmpty == true) {
      detailList.addAll(list ?? []);
      notifyListeners();
    } else {
      if (loadMore && _pageCount > 0) {
        _pageCount--;
      }
    }
  }
}
