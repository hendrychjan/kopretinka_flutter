import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopretinka_flutter/getx/app_controller.dart';
import 'package:kopretinka_flutter/pages/overview_page.dart';
import 'package:kopretinka_flutter/pages/welcome_page.dart';
import 'package:kopretinka_flutter/services/app_init_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await AppInitService.onStartInit();

      if (AppController.to.productCode.value.isEmpty) {
        Get.offAll(() => const WelcomePage());
      } else {
        Get.offAll(() => const OverviewPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
