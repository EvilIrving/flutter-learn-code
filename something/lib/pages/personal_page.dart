import 'package:flutter/material.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<StatefulWidget> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Page'),
      ),
      body: const Center(
        child: Text('This is the Personal Page'),
      ),
    );
  }
}
