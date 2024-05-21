import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class CustomElevatedButton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final Function() onPressed;
  final String text;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    this.padding,
    this.shape,
    required this.onPressed,
    required this.text,
     this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height?? 50,
        width: width?? 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor?? AppColors.primary,
            padding:  padding?? const EdgeInsets.all(5),
            shape:
              shape??  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: onPressed ,
          child: Text(
            text,
            style: textStyle?? getBodyStyle(color: AppColors.white),
          ),
        ));
  }
}
