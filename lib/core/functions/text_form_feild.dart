// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

Column appTextformFeild() {
  return Column(
    children: [
    TextFormField(
      decoration: InputDecoration(
          hintText: 'Aya4407@gmail.com',
          hintStyle: getSmallStyle(color: AppColors.grey,fontSize: 18),
          suffixIcon: Icon(
            Icons.mail,
          )),
    ),
    const Gap(2.5),
    TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.remove_red_eye_outlined,
          ),
          hintText: '********',
          hintStyle: getSmallStyle(color: AppColors.grey,fontSize: 20),
          suffixIcon: Icon(
            Icons.lock,
          )),
    ),
  ]);
}
