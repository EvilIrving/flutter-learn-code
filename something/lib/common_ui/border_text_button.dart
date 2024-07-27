import 'package:flutter/material.dart';

Widget borderTextButton({
  required String title,
  required Function() onPressed,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 40),
    height: 40,
    child: TextButton(
      style: ButtonStyle(
        backgroundColor:
            WidgetStateProperty.all<Color>(Colors.teal), // 设置背景颜色为白色
        overlayColor:
            WidgetStateProperty.all<Color>(Colors.cyan), // 设置按下时的覆盖颜色为青色
        shadowColor: WidgetStateProperty.all<Color>(Colors.grey), // 设置阴影颜色
        elevation: WidgetStateProperty.all<double>(5), // 设置阴影大小
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // 设置圆角为5
            side:
                const BorderSide(color: Colors.black, width: 1.5), // 设置边框颜色为青色
          ),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        title,
        style: const TextStyle(color: Colors.black), // 设置文字颜色为黑色
      ),
    ),
  );
}
