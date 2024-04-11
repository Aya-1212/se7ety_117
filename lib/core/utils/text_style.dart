import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';

TextStyle getTitleStyle ({Color? color , double? fontSize ,FontWeight? fontWeight}){
  return TextStyle(
    color: color ??AppColors.primary,fontSize: fontSize?? 22,fontWeight: fontWeight?? FontWeight.bold
  );
}

TextStyle getBodyStyle ({Color? color , double? fontSize ,FontWeight? fontWeight}){
  return TextStyle(
    color: color?? AppColors.black,fontSize: fontSize?? 18,fontWeight: fontWeight?? FontWeight.w500
  );
}

TextStyle getSmallStyle ({Color? color , double? fontSize ,FontWeight? fontWeight}){
  return TextStyle(
    color: color?? AppColors.mintGreen,fontSize: fontSize?? 12,fontWeight: fontWeight?? FontWeight.w300
  );
}