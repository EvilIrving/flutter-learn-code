import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Loading {
  Loading._(); // 禁止外部初始化

  static Future<void> showLoading() async {
    showToastWidget(
      Container(
        color: Colors.transparent,
        constraints: const BoxConstraints.expand(),
        child: Align(
          child: Container(
            padding:const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.black38,
            ),
            child: const CircularProgressIndicator(
              backgroundColor: Colors.black54,
              color: Colors.white,
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
      ),
      handleTouch: true,
      duration: const Duration(days: 1),
    );
  }

  static void dismissAll() {
    dismissAllToast();
  }
}
