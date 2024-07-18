import 'package:flutter/material.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<StatefulWidget> createState() => _HotKeyPageState();
}

class _HotKeyPageState extends State<HotKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HotKey Page'),
      ),
      body: const Center(
        child: Text('This is the HotKey Page'),
      ),
    );
  }
}
