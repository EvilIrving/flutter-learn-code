import 'package:flutter/material.dart';
import './pages/home.dart';
import './route/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      initialRoute: Routes.home,
      onGenerateRoute:
          Routes.generateRoute, // 使用自定义的 route.dart 中的 generateRoute 函数
    );
  }
}
