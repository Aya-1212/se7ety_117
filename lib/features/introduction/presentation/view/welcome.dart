// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/services/app_local_storage.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/features/authorization/presentation/view/sign_in.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: [
      Image.asset(
        AssetsImages.welcome,
        opacity: const AlwaysStoppedAnimation(0.5),
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Positioned(
        top: 100,
        right: 25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اهلا بيك',
              style: getTitleStyle(
                fontSize: 35,
              ),
            ),
            Text(
              'سجل و احجز عند دكتورك و انت فالبيت',
              style: getSmallStyle(color: AppColors.black),
            ),
          ],
        ),
      ),
   //   Spacer(),
      Positioned(
        bottom: 75,
        right: 25,
        left: 25,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'سجل دلوقتي كا',
                style: getBodyStyle(color: AppColors.white),
              ),
              Gap(20),
              CustomElevatedButton(
                onPressed: () {
                  AppLocalStorage.cacheData("isDoctor",true);
                  // 0 doctor
                 // AppLocalStorage.cacheUserData('isDoctor',true);
                  push(context, const SignInVeiw());
                },
                height: 60,
                text: 'دكتور',
                width: double.infinity,
                textStyle:getBodyStyle(color: AppColors.black,fontSize: 20),
                backgroundColor: AppColors.white.withOpacity(0.75),
              ),
              Gap(10),
      /////////////////////////////////////////////////////////        
              CustomElevatedButton(
                onPressed: () {
                   AppLocalStorage.cacheData("isDoctor",false);
                  // 1 patient
                  //AppLocalStorage.cacheUserData('isDoctor',false);
                  push(context,const SignInVeiw());         
                },
                height: 60,
                text: 'مريض',
                width: double.infinity,
                textStyle:getBodyStyle(color: AppColors.black,fontSize: 20),
                backgroundColor: AppColors.white.withOpacity(0.75),
              ),
            ],
          ),
        ),
      ),
    ])
    );
  }
}
