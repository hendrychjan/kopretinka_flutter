import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopretinka_flutter/pages/module_config_page.dart';
import 'package:kopretinka_flutter/pages/module_connect_page.dart';
import 'package:kopretinka_flutter/pages/qr_scan_page.dart';
import 'package:kopretinka_flutter/ui/local_theme.dart';

class WelcomePage extends StatefulWidget {
  final String? errorMessage;
  final String? successMessage;
  const WelcomePage({super.key, this.errorMessage, this.successMessage});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          widget.errorMessage!,
                          style: LocalTheme.error(),
                        ),
                      ),
                    if (widget.successMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          widget.successMessage!,
                          style: LocalTheme.success(),
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      "Kopretinka",
                      style: LocalTheme.heading1(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Connect to configured
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: IconButton(
                          iconSize: 50,
                          onPressed: () {
                            Get.to(
                              () => QRScanPage(
                                callback: (qr) => Get.off(
                                  () => ModuleConnectPage(productCode: qr),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.phonelink_ring,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                      // Module configuration
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: IconButton(
                          iconSize: 50,
                          onPressed: () {
                            Get.to(
                              () => QRScanPage(
                                callback: (qr) => Get.off(
                                  () => ModuleConfigPage(
                                    configQR: qr,
                                  ),
                                ),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.router,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
