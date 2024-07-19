import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  final String? title;
  final String? url;
  const ArticlePage({super.key, this.title, this.url}); // 修改构造函数参数

  @override
  State<StatefulWidget> createState() => ArticlePageState();
}

class ArticlePageState extends State<ArticlePage> {
  String? _articleTitle = '';
  String? _articleUrl = '这里是文章内容';

  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // 获取路由传值
  //     final args = ModalRoute.of(context)!.settings.arguments;
  //     if (args is Map) {
  //       _articleTitle = args['name'];
  //       _articleContent = args['content'];
  //       setState(() {});
  //     }
  //   });
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 获取路由传值
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args is Map) {
      _articleTitle = args['title'];
      _articleUrl = args['url'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_articleTitle ?? ''),
      ),
      body: Center(
          child: Column(
        children: [
          Text(_articleUrl ?? ''),
          ElevatedButton(
            child: const Text('返回'),
            onPressed: () {
              // 返回上一页
              Navigator.pop(context);
            },
          ),
        ],
      )),
    );
  }
}
