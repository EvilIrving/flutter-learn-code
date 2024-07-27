import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  List<String> labels = ["收藏", '检查更新', '关于我们'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(color: Colors.teal), // 设置绿色背景),
              alignment: Alignment.center,

              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 60, color: Colors.black),
                    Text(
                      "Your Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: buildMenus(labels, itemTap: (value) {
                print('点击了$value');
              }),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildMenus(List<String> labels,
      {ValueChanged<String>? itemTap}) {
    List<Widget> menuItems = [];
    for (int index = 0; index < labels.length; index++) {
      menuItems.add(buildMenuItem(labels[index], itemTap));
    }
    return menuItems;
  }

  Widget buildMenuItem(String label, ValueChanged<String>? itemTap) {
    return GestureDetector(
      onTap: () {
        itemTap?.call(label);
      },
      child: Container(
        width: double.infinity,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Row(
          children: [
            Text(label,
                style: const TextStyle(fontSize: 16, color: Colors.black)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
