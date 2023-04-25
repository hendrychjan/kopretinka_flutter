import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalTheme {
  static final ThemeData lightTheme = buildLightTheme();

  static TextStyle heading1() {
    return TextStyle(
      color: Get.theme.primaryColor,
      fontSize: 40,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle heading3() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle error() {
    return const TextStyle(
      color: Colors.red,
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle success() {
    return const TextStyle(
      color: Colors.green,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
  }

  static ThemeData buildLightTheme() {
    return ThemeData.light(useMaterial3: true);
    // return ThemeData.light(useMaterial3: true).copyWith(
    //   inputDecorationTheme: InputDecorationTheme(
    //     border: UnderlineInputBorder(
    //       borderSide: BorderSide(
    //         color: ThemeData.light().primaryColor,
    //       ),
    //       borderRadius: BorderRadius.circular(4),
    //     ),
    //     enabledBorder: UnderlineInputBorder(
    //       borderSide: const BorderSide(
    //         color: Colors.transparent,
    //       ),
    //       borderRadius: BorderRadius.circular(4),
    //     ),
    //     focusedBorder: UnderlineInputBorder(
    //       borderSide: BorderSide(
    //         color: ThemeData.light().primaryColor,
    //         width: 2,
    //       ),
    //       borderRadius: BorderRadius.circular(4),
    //     ),
    //     fillColor: const Color.fromARGB(12, 37, 141, 55),
    //     filled: true,
    //     hintStyle: TextStyle(
    //       color: ThemeData.light().primaryColor,
    //     ),
    //     labelStyle: TextStyle(
    //       color: ThemeData.light().primaryColor,
    //     ),
    //     iconColor: ThemeData.light().primaryColor,
    //   ),
    // );
  }
}
