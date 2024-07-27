import 'package:flutter/material.dart';
import '../pages/home_page.dart'; // 导入 home.dart 页面
import '../pages/articles_page.dart'; // 导入 article_page.dart 页面
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class Routes {
  static const String home = '/';
  static const String article = '/article';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return toPageRoute(const HomePage(), settings: settings);
      case login:
        return toPageRoute(const LoginPage(), settings: settings);
      case register:
        return toPageRoute(const RegisterPage(), settings: settings);
      case article:
        final args = settings.arguments;
        if (args is Map) {
          return toPageRoute(ArticlePage(title: args['name']),
              settings: settings);
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Error: Route not found!'),
        ),
      );
    });
  }

  static Route<dynamic> toPageRoute(
    Widget page, {
    RouteSettings settings = const RouteSettings(),
    bool maintainState = true,
    bool fullscreenDialog = false,
    bool allowSnapshotting = true,
    bool barrierDismissible = false,
  }) {
    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
      allowSnapshotting: allowSnapshotting,
      barrierDismissible: barrierDismissible,
    );
  }
}
