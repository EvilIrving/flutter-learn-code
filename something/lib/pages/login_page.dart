import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:something/common_ui/border_input.dart';
import 'package:something/common_ui/border_text_button.dart';
import 'package:something/model/auth_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(''),
        ),
        backgroundColor: Colors.teal,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Consumer<LoginModel>(
            builder: (context, vm, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextField('woshidaren', Icons.person, _usernameController,
                      (value) => vm.loginForm.username = value,   true , obscureText: false),
                  const SizedBox(height: 16),
                  buildTextField('123456', Icons.https,  _passwordController,
                      (value) => vm.loginForm.password = value, false,obscureText: true),
                  const SizedBox(height: 36),
                  borderTextButton(
                    title: '登录',
                    onPressed: () async {
                      vm.loginUser().then((value) {
                        if (value) {
                          // TODO 登录成功后跳转到主页, 保存个人信息
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: const Text(
                      '注册',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
