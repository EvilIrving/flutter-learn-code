import 'package:flutter/material.dart';
import 'package:something/pages/about_us_page.dart';
import 'package:something/pages/collect_page.dart';
import 'package:something/pages/knowledeg_detail_tab_page.dart';
import 'package:something/pages/search_page.dart';
import '../pages/home_page.dart'; // 导入 home.dart 页面
import '../pages/articles_page.dart'; // 导入 article_page.dart 页面
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class Routes {
  static const String home = '/';
  static const String article = '/article';
  static const String login = '/login';
  static const String register = '/register';
  static const String knowledegTab = '/knowledegTab';
  static const String search = '/search';
  static const String aboutus = '/aboutus';
  static const String collect = '/collect';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return toPageRoute(const HomePage(), settings: settings);
      case login:
        return toPageRoute(const LoginPage(), settings: settings);
      case register:
        return toPageRoute(const RegisterPage(), settings: settings);
      case knowledegTab:
        return toPageRoute(const KnowledegDetailTabPage(), settings: settings);
      case search:
        return toPageRoute(const SearchPage(), settings: settings);
      case aboutus:
        return toPageRoute(const AboutUsPage(), settings: settings);
      case collect:
        return toPageRoute(const MyCollectsPage(), settings: settings);
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
      return Scaffold(
        appBar: AppBar(
          title: const Text('not found'),
        ),
        body: const Center(
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
