import 'package:flutter/material.dart';
import '../shared/global/colors.dart';

InputDecoration inputDecorationBorderGreen(
    {Icon? icon, String? hintText, Widget? suffixIcon}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorStyles.primaryColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorStyles.primaryColor,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    labelStyle: const TextStyle(
      color: Color(0xFF308A40),
    ),
    prefixIcon: icon,
    suffixIcon: suffixIcon,
    hintText: hintText,
    hintStyle: TextStyle(
      color: ColorStyles.bodyColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
  );
}
