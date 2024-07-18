import 'package:flutter/material.dart';
import 'package:something/common_ui/navigation_item.dart';

class NavigationBarWidget extends StatefulWidget {
  final List<Widget> pages;

  final List<Widget> icons;

  final List<Widget> activeIcons;

  final List<String> labels;

  final ValueChanged<int>? onTabChanged;

  int? currentIndex;

  NavigationBarWidget({
    super.key,
    required this.labels,
    required this.pages,
    required this.icons,
    required this.activeIcons,
    this.onTabChanged,
    this.currentIndex,
  }) {
    if (pages.length != labels.length &&
        pages.length != icons.length &&
        pages.length != activeIcons.length) {
      throw Exception(
          "The length of pages, items, icons and activeIcons must be the same");
    }
  }

  @override
  State<StatefulWidget> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: widget.currentIndex ?? 0,
          children: widget.pages,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.white,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: _buildBottomNavigationBarItems(),
          currentIndex: widget.currentIndex ?? 0,
          // 实现渐变色效果
          selectedIconTheme:
              const IconThemeData(color: Colors.blue), // 设置选中图标颜色
          unselectedIconTheme: const IconThemeData(color: Colors.grey), // 设
          selectedLabelStyle: const TextStyle(color: Colors.blue),
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          onTap: (int index) {
            widget.onTabChanged?.call(index);
          },
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems() {
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < widget.pages.length; i++) {
      items.add(BottomNavigationBarItem(
        icon: widget.icons[i],
        label: widget.labels[i],
        activeIcon: NavigationBarItem(
          builder: (BuildContext context) {
            return widget.activeIcons[i];
          },
        ),
      ));
    }
    return items;
  }
}
