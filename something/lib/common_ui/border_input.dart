import 'package:flutter/material.dart';

Widget buildTextField(
  String text,
  IconData? icon,
  TextEditingController controller,
  ValueChanged<String> onChanged,
  bool next, {
  bool? obscureText,
}) {
  Color black = Colors.black;
  OutlineInputBorder border({double? width}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: black, width: width ?? 1.0),
    );
  }

  return TextField(
    onTap: () {},
    style: TextStyle(color: black, fontSize: 18),
    obscuringCharacter: "*",
    obscureText: obscureText ?? false,
    onChanged: onChanged,
    decoration: InputDecoration(
        prefixIcon: Icon(icon),
        label: Text(text),
        labelStyle: TextStyle(fontSize: 17, color: black),
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(width: 2),
        hintText: '请输入$text'),
    autofocus: true,
    controller: controller,
    textInputAction: next == true ? TextInputAction.next : TextInputAction.done,
    onSubmitted: (value) {
      print(value);
    },
  );
}
