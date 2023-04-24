import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalTheme {
  static TextStyle heading1() {
    return TextStyle(
      color: Get.theme.primaryColor,
      fontSize: 40,
      fontWeight: FontWeight.w700,
    );
  }
}
