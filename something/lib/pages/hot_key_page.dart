import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:something/data/hot_key_data.dart';
import 'package:something/route/routes.dart';
import '../model/hot_key_model.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<StatefulWidget> createState() => _HotKeyPageState();
}

class _HotKeyPageState extends State<HotKeyPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HotPageModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('热点诶'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Column(children: [
                    buildHeaderWrapper('热点词汇', icon: const Icon(Icons.search)),
                    Consumer<HotPageModel>(builder: (context, hotModel, child) {
                      return buildGridView(true,
                          hotKeyList: hotModel.hotKeyItems, itemTap: (value) {
                        print('hotkey:$value');
                      });
                    }),
                    buildHeaderWrapper('热点网站'),
                    Consumer<HotPageModel>(builder: (context, hotModel, child) {
                      return buildGridView(false,
                          hotWebList: hotModel.hotWebItems, itemTap: (value) {
                        Navigator.pushNamed(context, Routes.article,
                            arguments: {'title': '热点网站', 'url': value});
                      });
                    }),
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHeaderWrapper(String name, {Widget? icon}) {
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey, width: 1),
            bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Text(name),
          const Spacer(),
          // 搜索图标
          if (icon != null)
            IconButton(
              icon: icon,
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget buildGridView(bool isHotKey,
      {List<HotKeyItem>? hotKeyList,
      List<HotWebItem>? hotWebList,
      ValueChanged<String>? itemTap}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 2.0,
      ),
      itemCount: isHotKey ? hotKeyList?.length ?? 0 : hotWebList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (isHotKey) {
          return buildGridViewItem(
              name: hotKeyList?[index].name, itemTap: itemTap);
        } else {
          return buildGridViewItem(
              name: hotWebList?[index].name,
              link: hotWebList?[index].link,
              itemTap: itemTap);
        }
      },
    );
  }

  Widget buildGridViewItem(
      {String? name, String? link, ValueChanged<String>? itemTap}) {
    return GestureDetector(
      onTap: () {
        if (link == null) {
          itemTap?.call(name ?? '');
        } else {
          itemTap?.call(link);
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          name ?? '',
          style: const TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
