import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:something/data/knowledeg_data.dart';
import 'package:something/model/knowledeg_tab_model.dart';
import 'package:something/pages/knowledeg_detail_tab_child_page.dart';

class KnowledegDetailTabPage extends StatefulWidget {
  const KnowledegDetailTabPage({super.key, this.tabList});

  final List<KnowledegChildren>? tabList;

  @override
  State<StatefulWidget> createState() {
    return _KnowledgeDetailTabState();
  }
}

class _KnowledgeDetailTabState extends State<KnowledegDetailTabPage>
    with SingleTickerProviderStateMixin {
  KnowledegTabModel knowledegTabModel = KnowledegTabModel();
  late TabController tabController;

  @override
  void initState() {
    tabController =
        TabController(length: widget.tabList?.length ?? 0, vsync: this);
    knowledegTabModel.initTabs(widget.tabList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => knowledegTabModel,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: knowledegTabModel.tabs,
            controller: tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            children: children(),
          ),
        ),
      ),
    );
  }

  List<Widget> children() {
    return widget.tabList?.map((tab) {
          return KnowledegTabChildPage(cid: '${tab.id}');
        }).toList() ??
        [];
  }
}
