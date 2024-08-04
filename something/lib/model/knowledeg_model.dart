import 'package:flutter/material.dart';
import 'package:something/api/knowledeg_api.dart';
import 'package:something/data/knowledeg_data.dart';

class KnowledegPageModel extends ChangeNotifier {
  List<KnowledegList>? knowledegList = [];
  KnowledegPageModel() {
    initData();
  }

  Future<void> initData() async {
    knowledegList = await KnowledegApi.getKnowledegTree();
    notifyListeners();
  }

  String generateSubtitle(List<KnowledegChildren>? children) {
    if (children == null || children.isEmpty == true) {
      return '';
    }

    StringBuffer subtitle = StringBuffer('');
    for (var child in children) {
      subtitle.write('${child.name} ');
    }

    return subtitle.toString();
  }
}
