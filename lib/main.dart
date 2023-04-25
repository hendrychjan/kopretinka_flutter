import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kopretinka_flutter/pages/welcome_page.dart';
import 'package:kopretinka_flutter/ui/local_theme.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Kopretinka',
    home: const WelcomePage(),
    theme: LocalTheme.lightTheme,
  ));
}
