// 实现 tab 点击 动画效果

import 'package:flutter/material.dart';

class NavigationBarItem extends StatefulWidget {
  final WidgetBuilder builder;
  const NavigationBarItem({
    super.key,
    required this.builder,
  });

  @override
  State<StatefulWidget> createState() => _NavigationBarItemState();
}

class _NavigationBarItemState extends State<NavigationBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animationController.forward();
    _animation = Tween(begin: 0.8, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _animationController.forward();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return GestureDetector(
  //     onTap: _handleTap,
  //     child: FadeTransition(
  //       opacity: _animation,
  //       child: widget.builder(context),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _animation, child: widget.builder(context));
  }
}
