import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:something/common_ui/border_text_button.dart';
import 'package:something/common_ui/smart_refresh.dart';
import 'package:something/data/my_collects_data.dart';
import 'package:something/model/collect_model.dart';

///我的收藏页面
class MyCollectsPage extends StatefulWidget {
  const MyCollectsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyCollectsPageState();
  }
}

class _MyCollectsPageState extends State<MyCollectsPage> {
  MyCollectsViewModel model = MyCollectsViewModel();
  late RefreshController _refreshController;

  @override
  void initState() {
    _refreshController = RefreshController();
    super.initState();
    refreshOrLoad(false);
  }

  void refreshOrLoad(bool loadMore) {
    model.getMyCollects(loadMore).then((value) {
      if (loadMore) {
        _refreshController.loadComplete();
      } else {
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return model;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('我的收藏'),
        ),
        body: SafeArea(
          child: Consumer<MyCollectsViewModel>(builder: (context, vm, child) {
            return SmartRefreshWidget(
              controller: _refreshController,
              onRefresh: () {
                refreshOrLoad(false);
              },
              onLoading: () {
                refreshOrLoad(true);
              },
              child: ListView.builder(
                  itemCount: vm.dataList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return _collectItem(vm.dataList?[index], onTap: () {
                      //取消收藏
                      model.cancelCollect(index, "${vm.dataList?[index].id}");
                    }, itemClick: () {});
                  }),
            );
          }),
        ),
      ),
    );
  }

  Widget _collectItem(MyCollectItemModel? item,
      {GestureTapCallback? onTap, GestureTapCallback? itemClick}) {
    return GestureDetector(
        onTap: itemClick,
        child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text("作者: ${item?.author}"),
                ),
                Text("时间: ${item?.niceDate}")
              ]),
              Text("${item?.title}", style: titleTextStyle15),
              Row(children: [
                Expanded(child: Text("分类: ${item?.chapterName}")),
                IconButton(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ]),
            ])));
  }
}
