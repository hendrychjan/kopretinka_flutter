import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopretinka_flutter/getx/app_controller.dart';
import 'package:kopretinka_flutter/pages/splash_page.dart';
import 'package:kopretinka_flutter/pages/welcome_page.dart';
import 'package:kopretinka_flutter/ui/local_theme.dart';

void main() {
  Get.put(AppController());

  runApp(GetMaterialApp(
    title: 'Kopretinka',
    home: const SplashPage(),
    theme: LocalTheme.lightTheme,
  ));
}
