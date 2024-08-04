import 'package:flutter/material.dart';

class RouterUtils {
  RouterUtils._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;
  static NavigatorState get navigator => navigatorKey.currentState!;

  static Future push(context, page,
      {bool? fullscreenDialog,
      RouteSettings? setting,
      bool maintainState = true}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => page,
          fullscreenDialog: fullscreenDialog ?? false,
          settings: setting,
          maintainState: maintainState),
    );
  }

  static Future pushForNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Future keepTargetName(
    BuildContext context,
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(context, newRouteName, predicate);
  }

  static void pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static void popOfData<T extends Object>(BuildContext context, {T? result}) {
    return Navigator.of(context).pop<T>(result);
  }
}
