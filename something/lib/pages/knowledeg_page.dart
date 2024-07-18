import 'package:flutter/material.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<StatefulWidget> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Knowledge Page'),
      ),
      body: const Center(
        child: Text('This is the Knowledge Page'),
      ),
    );
  }
}
