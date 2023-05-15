import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopretinka_flutter/forms/module_config_form.dart';
import 'package:kopretinka_flutter/pages/welcome_page.dart';
import 'package:kopretinka_flutter/services/module_control_service.dart';

class ModuleConfigPage extends StatefulWidget {
  final String configQR;
  const ModuleConfigPage({super.key, required this.configQR});

  @override
  State<ModuleConfigPage> createState() => _ModuleConfigPageState();
}

class _ModuleConfigPageState extends State<ModuleConfigPage> {
  late ModuleConfigState _state;

  Future<void> _connectToModule() async {
    try {
      await ModuleControlService.connectToModuleWifi();
    } catch (e) {
      Get.off(
        () =>
            const WelcomePage(errorMessage: "Nepodařilo se připojit k modulu"),
      );
      return;
    }

    setState(() {
      _state = ModuleConfigState.waitingForConfig;
    });
  }

  Future<void> _uploadConfig(Map<String, dynamic> moduleConfig) async {
    setState(() {
      _state = ModuleConfigState.programming;
    });

    await ModuleControlService.uploadConfiguration(moduleConfig);
    // try {
    //   await ModuleControlService.uploadConfiguration(
    //       widget.configQR, moduleConfig);
    // } catch (e) {
    //   Get.off(
    //     () =>
    //         const WelcomePage(errorMessage: "Nepodařilo se nahrát konfiguraci"),
    //   );
    //   rethrow;
    // }

    Get.offAll(() => const WelcomePage(successMessage: "Konfigurace nahrána"));
  }

  @override
  void initState() {
    super.initState();
    _state = ModuleConfigState.connecting;

    if (!ModuleControlService.parseConfigQR(widget.configQR)) {
      Future.delayed(Duration.zero, () {
        Get.offAll(
          () => const WelcomePage(errorMessage: "QR kód je neplatný"),
        );
      });
      return;
    }

    Future.delayed(Duration.zero, _connectToModule);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Nastavení modulu"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: (_state == ModuleConfigState.connecting ||
                    _state == ModuleConfigState.programming)
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              if (_state == ModuleConfigState.connecting)
                const _WaitingStatusIndicatorWidget(
                    statusMessage: "Připojování k modulu..."),
              if (_state == ModuleConfigState.programming)
                const _WaitingStatusIndicatorWidget(
                    statusMessage: "Odesílání konfigurace..."),
              if (_state == ModuleConfigState.waitingForConfig)
                ModuleConfigForm(
                  onSubmit: _uploadConfig,
                ),
              if (_state == ModuleConfigState.error)
                const Text("Nastala chyba při připojování k modulu"),
            ],
          ),
        ),
      ),
    );
  }
}

class _WaitingStatusIndicatorWidget extends StatefulWidget {
  final String statusMessage;
  const _WaitingStatusIndicatorWidget({required this.statusMessage});

  @override
  State<_WaitingStatusIndicatorWidget> createState() =>
      __WaitingStatusIndicatorWidgetState();
}

class __WaitingStatusIndicatorWidgetState
    extends State<_WaitingStatusIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 8.0, top: 16),
          child: CircularProgressIndicator(),
        ),
        Text(widget.statusMessage),
      ],
    );
  }
}

enum ModuleConfigState {
  connecting,
  waitingForConfig,
  programming,
  error,
}
