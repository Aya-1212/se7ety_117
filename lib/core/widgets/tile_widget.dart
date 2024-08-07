import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class TileWidget extends StatelessWidget {
  const TileWidget({
    super.key,
    required this.iconData,
    required this.text,
  });
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 17,
          child: Icon(
            iconData,
            color: AppColors.white,
          ),
        ),
        const Gap(10),
        Text(
          text,
          style: getBodyStyle(),
        ),
      ],
    );
  }
}
