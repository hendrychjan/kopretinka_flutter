import 'package:flutter/material.dart';

class ModuleConfigPage extends StatefulWidget {
  final String wifiConfig;
  const ModuleConfigPage({super.key, required this.wifiConfig});

  @override
  State<ModuleConfigPage> createState() => _ModuleConfigPageState();
}

class _ModuleConfigPageState extends State<ModuleConfigPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.wifiConfig);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nastavení modulu"),
      ),
      body: const Placeholder(),
    );
  }
}
