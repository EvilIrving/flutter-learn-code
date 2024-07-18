import 'package:flutter/material.dart';

class ArticlePage extends StatefulWidget {
  final String title; // 添加一个 final 字段用于存储 title

  const ArticlePage({super.key, required this.title}); // 修改构造函数参数

  @override
  State<StatefulWidget> createState() => ArticlePageState();
}

class ArticlePageState extends State<ArticlePage> {
  String _articleTitle = '';
  String _articleContent = '这里是文章内容';

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
      _articleTitle = args['name'];
      _articleContent = args['content'];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_articleTitle.isNotEmpty ? _articleTitle : widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          Text(_articleContent),
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
