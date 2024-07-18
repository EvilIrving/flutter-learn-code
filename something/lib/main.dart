import 'package:flutter/material.dart';
import 'package:something/pages/tab_page.dart';

import 'route/Routes.dart';
import 'request/http_dio.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  Request.init(baseUrl: 'https://wanandroid.com'); // 初始化请求库
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TabPage(),
        initialRoute: Routes.home,
        onGenerateRoute:
            Routes.generateRoute, // 使用自定义的 route.dart 中的 generateRoute 函数
      ),
    );
  }
}
