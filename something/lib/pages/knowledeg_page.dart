import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:something/data/knowledeg_data.dart';
import 'package:something/model/knowledeg_model.dart';
import 'package:something/pages/knowledeg_detail_tab_page.dart';
import 'package:something/route/router_util.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledegPageModel knowledegPageModel = KnowledegPageModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => knowledegPageModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('芝士🧀'),
        ),
        body: Consumer<KnowledegPageModel>(builder: (context, vm, child) {
          return ListView.builder(
            itemCount: vm.knowledegList?.length ?? 0,
            itemBuilder: (ctx, index) {
              return buildListItem(vm.knowledegList?[index]);
            },
          );
        }),
      ),
    );
  }

  Widget buildListItem(KnowledegList? item) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  item?.name ?? '',
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  knowledegPageModel.generateSubtitle(item?.children),
                  // softWrap: true,
                  // style: const TextStyle(color: Colors.black26),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                RouterUtils.push(
                    context, KnowledegDetailTabPage(tabList: item?.children));
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded))
        ],
      ),
    );
  }
}
