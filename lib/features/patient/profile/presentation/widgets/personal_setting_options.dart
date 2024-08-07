import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class PersonalSettingsWidget extends StatelessWidget {
  const PersonalSettingsWidget({
    super.key,
    required this.settingText,
    required this.settingIcon,
    required this.onTap,
  });

  final String settingText;
  final Icon settingIcon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.textFormFieldbg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            settingIcon,
            // const  Icon(Icons.person, color: AppColors.black,),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                settingText,
                style: getBodyStyle(fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
