import 'package:flutter/material.dart';
import 'package:something/route/router_util.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  List<Map<String, String>> labels = [
    {'label': '收藏', 'router': "/collect"},
    {'label': '检查更新', 'router': "/update"},
    {'label': '关于我们', 'router': "/aboutus"}
  ];

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
                RouterUtils.pushForNamed(context, value);
              }),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildMenus(List<Map<String, String>> labels,
      {ValueChanged<String>? itemTap}) {
    List<Widget> menuItems = [];
    for (int index = 0; index < labels.length; index++) {
      menuItems.add(buildMenuItem(labels[index], itemTap));
    }
    return menuItems;
  }

  Widget buildMenuItem(
      Map<String, String> label, ValueChanged<String>? itemTap) {
    return GestureDetector(
      onTap: () {
        itemTap?.call(label['router'] ?? '');
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
            Text(
              label['label'] ?? '',
              // style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              // color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
