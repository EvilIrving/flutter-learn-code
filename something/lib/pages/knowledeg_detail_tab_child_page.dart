import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:something/common_ui/border_text_button.dart';
import 'package:something/common_ui/loading.dart';
import 'package:something/common_ui/smart_refresh.dart';
import 'package:something/data/knowledeg_tab_child_data.dart';
import 'package:something/model/knowledeg_tab_model.dart';

class KnowledegTabChildPage extends StatefulWidget {
  const KnowledegTabChildPage({super.key, required this.cid});

  final String cid;
  @override
  State<StatefulWidget> createState() {
    return KnowledegTabChildState();
  }
}

class KnowledegTabChildState extends State<KnowledegTabChildPage> {
  KnowledegTabModel knowledegTabModel = KnowledegTabModel();
  RefreshController refreshController = RefreshController();
  @override
  void initState() {
    Loading.showLoading();
    refreshOrLoad(false).then((value) {
      Loading.dismissAll();
    });
    super.initState();
  }

  Future refreshOrLoad(bool loadMore) async {
    await knowledegTabModel.getTabDetail(widget.cid, loadMore);
    if (loadMore) {
      refreshController.loadComplete();
    } else {
      refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => knowledegTabModel,
      child: Scaffold(
        body: SafeArea(
          child: Consumer<KnowledegTabModel>(builder: (context, vm, child) {
            return SmartRefreshWidget(
              controller: refreshController,
              child: ListView.builder(
                  itemCount: vm.detailList.length,
                  itemBuilder: (context, index) {
                    return _item(vm.detailList[index], onTap: () {
                      // vm.detailList[index].apkLink
                    });
                  }),
              onLoading: () => refreshOrLoad(true),
              onRefresh: () => refreshOrLoad(false),
            );
          }),
        ),
      ),
    );
  }

  Widget _item(KnowledegTabDetail item, {GestureTapCallback? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5)),
            child: Column(children: [
              Row(
                children: [
                  normalText(item.superChapterName ?? ''),
                  const Expanded(child: SizedBox()),
                  Text("${item.niceShareDate}"),
                ],
              ),
              Text("${item.title}", style: titleTextStyle15),
              Row(
                children: [
                  normalText(item.chapterName ?? ''),
                  const Expanded(child: SizedBox()),
                  Text("${item.shareUser}"),
                ],
              )
            ])));
  }
}
