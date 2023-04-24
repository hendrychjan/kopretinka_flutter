import 'package:flutter/material.dart';

class ModuleConnectPage extends StatefulWidget {
  final String productCode;
  const ModuleConnectPage({super.key, required this.productCode});

  @override
  State<ModuleConnectPage> createState() => _ModuleConnectPageState();
}

class _ModuleConnectPageState extends State<ModuleConnectPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.productCode);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Připojení k modulu"),
      ),
      body: const Placeholder(),
    );
  }
}
