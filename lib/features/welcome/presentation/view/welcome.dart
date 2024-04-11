// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/services/app_local.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/welcome/presentation/view/splash.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack (
          
      children: [
      Image.asset(
        AssetsImages.welcome,
        opacity: const AlwaysStoppedAnimation(0.5),
        fit: BoxFit.fill,
        height: double.infinity,
        width: double.infinity,
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
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
            
            const Gap(15),
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Text(
                      'سجل دلوقتي كا',
                      style:
                          getSmallStyle(color: AppColors.white, fontSize: 18),
                    ),
                    const Gap(30),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          AppLocalStorage.cacheUserData('isDoctor',true);
                          pushWithReplacement(context, SplashView() );
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(13),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.textFormFieldbg.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            'دكتور',
                            style: getBodyStyle(color: AppColors.black),
                          )),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: InkWell(
                        onTap: (){
                          AppLocalStorage.cacheUserData('isDoctor',false);
                          pushWithReplacement(context, SplashView() );
                        },
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(13),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.textFormFieldbg.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            'مريض',
                            style: getBodyStyle(color: AppColors.black),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
