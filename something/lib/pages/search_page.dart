import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:something/common_ui/border_text_button.dart';
import 'package:something/common_ui/loading.dart';
import 'package:something/data/search_data.dart';
import 'package:something/model/search_model.dart';

class SearchPage extends StatefulWidget {
  final String? word;

  const SearchPage({super.key, this.word});

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel = SearchModel();
  TextEditingController? _editController;

  @override
  void initState() {
    _editController = TextEditingController(text: widget.word ?? "");
    Loading.showLoading();
    searchModel.searchBy(widget.word ?? '').then((value) {
      Loading.dismissAll();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => searchModel,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // 搜索栏
              _searchBar(onSubmitted: (value) async {
                Loading.showLoading();
                await searchModel.searchBy(value);
                Loading.dismissAll();
              }, onTapCancel: () {
                var text = _editController?.text;
                if (text == null || text == '') {
                  Navigator.pop(context);
                } else {
                  _editController?.text = '';
                  searchModel.clear();
                }
              }, onTapFinish: () {
                Navigator.pop(context);
              }),
              // 搜索结果
              Consumer<SearchModel>(builder: (context, vm, child) {
                return _searchResultsView(vm.searchResult ?? []);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(
      {ValueChanged<String>? onSubmitted,
      VoidCallback? onTapCancel,
      VoidCallback? onTapFinish}) {
    return Container(
        color: Colors.teal,
        height: 50,
        child: Row(children: [
          IconButton(
            highlightColor: Colors.teal,
            onPressed: onTapFinish,
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          Expanded(
              child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: TextField(
                    textAlign: TextAlign.justify,
                    controller: _editController,
                    style: titleTextStyle15,
                    decoration: _inputDecoration(),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    onSubmitted: onSubmitted,
                  ))),
          TextButton(
              onPressed: onTapCancel,
              child: Text("取消", style: whiteTextStyle15)),
        ]));
  }

  Widget _searchResultsView(List<SearchListItemModel> list,
      {ValueChanged<SearchListItemModel?>? onItemTap}) {
    return Expanded(
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              var item = list[index];
              return _resultItem(item, onItemTap: () {
                onItemTap?.call(item);
              });
            }));
  }

  Widget _resultItem(SearchListItemModel? item,
      {GestureTapCallback? onItemTap}) {
    return GestureDetector(
        onTap: onItemTap,
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
          width: double.infinity,
          child: Html(data: item?.title ?? "", style: {
            //整体样式使用 html
            "html": Style(fontSize: FontSize(15))
          }),
        ));
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
        contentPadding: const EdgeInsets.only(left: 10),
        fillColor: Colors.white,
        filled: true,
        enabledBorder: _inputBorder(),
        focusedBorder: _inputBorder(),
        border: _inputBorder());
  }

  OutlineInputBorder _inputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15)));
  }
}
