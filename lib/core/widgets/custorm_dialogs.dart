import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

showErrorDialog(context, {required String errorMessage}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        errorMessage,
        style: getBodyStyle(color: AppColors.white),
      ),
      backgroundColor: Colors.redAccent,
    ),
  );
}

showLoadingDialog(context) {
  return showDialog(
    barrierColor: AppColors.black.withOpacity(0.7),
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset('assets/on2.svg', height: 100, width: 100,fit: BoxFit.cover), //Image.memory(bytes)
        Lottie.asset('assets/loading.json',
              height: 150, width: 150, fit: BoxFit.cover),
        ],
      );
    },
  );
}
