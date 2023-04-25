import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormComponents {
  static Widget renderTextInput({
    required String hint,
    required TextEditingController controller,
    required List<String> validationRules,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Icon? icon,
    Function? onSubmit,
    int? minLines,
    int? maxLines,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hint,
          //labelText: hint,
          prefixIcon: icon,
        ),
        obscureText: obscureText,
        validator: (value) {
          return _handleValidate(value.toString(), validationRules);
        },
        onFieldSubmitted: (value) {
          if (onSubmit != null) onSubmit(value);
        },
        minLines: minLines ?? 1,
        maxLines: maxLines ?? 1,
      ),
    );
  }

  static Widget renderCheckbox({
    required bool value,
    required Function onChange,
    required String hint,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 0),
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: (v) => onChange(v),
            activeColor: Get.theme.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text(hint),
          ),
          if (icon != null)
            Icon(
              icon,
              color: (value) ? Get.theme.primaryColor : Colors.grey,
            ),
        ],
      ),
    );
  }

  static String? _handleValidate(String? value, List<String> validationRules) {
    if (validationRules.contains("required")) {
      if (value == null || value.isEmpty) {
        return "Povinné pole";
      }
    }

    return null;
  }
}
