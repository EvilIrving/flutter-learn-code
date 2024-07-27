import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:something/common_ui/border_input.dart';
import 'package:something/common_ui/border_text_button.dart';
import 'package:something/model/auth_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordAgainController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordAgainController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text(''),
        ),
        backgroundColor: Colors.teal,
        body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Consumer<AuthModel>(
              builder: (context, vm, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTextField('用户名', Icons.person, _usernameController,
                        (value) => vm.registerForm.username = value, true,
                        obscureText: false),
                    const SizedBox(height: 16),
                    buildTextField('密码', Icons.https, _passwordController,
                        (value) => vm.registerForm.password = value, true,
                        obscureText: true),
                    const SizedBox(height: 16),
                    buildTextField(
                        '确认密码',
                        Icons.check,
                        _passwordAgainController,
                        (value) => vm.registerForm.repassword = value,
                        false,
                        obscureText: true),
                    const SizedBox(height: 36),
                    borderTextButton(
                      title: '注册',
                      onPressed: () async {
                        vm.registerUser().then((value) {
                          if (value) {
                            Navigator.pop(context);
                          }
                        });
                      },
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
