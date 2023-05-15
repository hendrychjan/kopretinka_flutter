import 'package:flutter/material.dart';
import 'package:kopretinka_flutter/ui/form_components.dart';
import 'package:kopretinka_flutter/ui/local_theme.dart';

class ModuleConfigForm extends StatefulWidget {
  final Function onSubmit;
  const ModuleConfigForm({super.key, required this.onSubmit});

  @override
  State<ModuleConfigForm> createState() => _ModuleConfigFormState();
}

class _ModuleConfigFormState extends State<ModuleConfigForm> {
  final _formKey = GlobalKey<FormState>();
  final _ssidController = TextEditingController(text: "wifissid");
  final _passwordController = TextEditingController(text: "wifipassword");
  final _serverController = TextEditingController(text: "192.168.1.30:7000");
  final Set<int> _enabledPorts = {1, 4, 6, 8};

  bool _isEnabled(int port) {
    return _enabledPorts.contains(port);
  }

  void _switchPort(int port) {
    setState(() {
      if (_isEnabled(port)) {
        _enabledPorts.remove(port);
      } else {
        _enabledPorts.add(port);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: FormComponents.renderTextInput(
                icon: const Icon(Icons.wifi),
                hint: "SSID WiFi sítě",
                controller: _ssidController,
                validationRules: ["required"],
              ),
            ),
            FormComponents.renderTextInput(
              icon: const Icon(Icons.wifi_password),
              hint: "Heslo WiFi sítě",
              controller: _passwordController,
              validationRules: ["required"],
            ),
            FormComponents.renderTextInput(
              icon: const Icon(Icons.computer),
              hint: "IP adresa serveru",
              controller: _serverController,
              validationRules: ["required"],
            ),
            Text(
              "Aktivní porty",
              style: LocalTheme.heading3(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      for (int i = 0; i <= 7; i++)
                        FormComponents.renderCheckbox(
                          value: _isEnabled(i),
                          onChange: (status) => _switchPort(i),
                          hint: "$i",
                          icon: Icons.power,
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 8; i <= 15; i++)
                        FormComponents.renderCheckbox(
                          value: _isEnabled(i),
                          onChange: (status) => _switchPort(i),
                          hint: "$i",
                          icon: Icons.power,
                        ),
                    ],
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                widget.onSubmit({
                  "ssid": _ssidController.text,
                  "password": _passwordController.text,
                  "serverIp": _serverController.text.split(":")[0],
                  "serverPort": _serverController.text.split(":")[1],
                  "ports": _enabledPorts.toList(),
                });
              },
              child: const Text("Naprogramovat"),
            ),
          ],
        ),
      ),
    );
  }
}
