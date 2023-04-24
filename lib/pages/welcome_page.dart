import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopretinka_flutter/pages/module_config_page.dart';
import 'package:kopretinka_flutter/pages/module_connect_page.dart';
import 'package:kopretinka_flutter/pages/qr_scan_page.dart';
import 'package:kopretinka_flutter/ui/theme.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
                              wifiConfig: qr,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
