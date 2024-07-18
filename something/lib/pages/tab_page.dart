import 'package:flutter/material.dart';
import 'package:something/common_ui/navigation_bar.dart';
import 'package:something/pages/home_page.dart';
import 'package:something/pages/hot_key_page.dart';
import 'package:something/pages/knowledeg_page.dart';
import 'package:something/pages/personal_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<StatefulWidget> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;

  late List<Widget> pages;

  late List<Widget> icons;

  late List<Widget> activeIcons;

  late List<String> labels;

  late ValueChanged<int>? onTabChanged;

  void initState() {
    super.initState();

    initTabData();
  }

  void initTabData() {
    pages = [
      const HomePage(),
      const KnowledgePage(),
      const HotKeyPage(),
      const PersonalPage()
    ];
    icons = [
      const Icon(Icons.home),
      const Icon(Icons.all_inclusive),
      const Icon(Icons.ads_click),
      const Icon(Icons.account_circle),
    ];
    activeIcons = [
      const Icon(Icons.home_outlined),
      const Icon(Icons.all_inclusive_outlined),
      const Icon(Icons.ads_click_outlined),
      const Icon(Icons.account_circle_outlined),
    ];
    labels = ['首页', '知识库', '热点', '我的'];
    onTabChanged = (int index) {
      setState(() {
        currentIndex = index;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarWidget(
        pages: pages,
        icons: icons,
        activeIcons: activeIcons,
        labels: labels,
        onTabChanged: onTabChanged,
        currentIndex: currentIndex);
  }
}
