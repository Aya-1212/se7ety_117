import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class Apptheme {
  static ThemeData lightTheme = ThemeData(
      fontFamily: GoogleFonts.cairo().fontFamily,
      scaffoldBackgroundColor: AppColors.white,
      // ignore: prefer_const_constructors
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary, foregroundColor: AppColors.white),
      inputDecorationTheme: InputDecorationTheme(
          fillColor: AppColors.textFormFieldbg,
          filled: true,
          prefixIconColor: AppColors.primary,
          suffixIconColor: AppColors.primary,
          contentPadding:
              const EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 18),
          constraints: const BoxConstraints(minHeight: 70),
          hintStyle: getSmallStyle(color: AppColors.grey),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(style: BorderStyle.none)),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(style: BorderStyle.none)),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(style: BorderStyle.none)),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                style: BorderStyle.none,
              ))));
}
