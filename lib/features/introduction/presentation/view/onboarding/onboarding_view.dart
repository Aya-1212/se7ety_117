import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/features/introduction/presentation/view/onboarding/onboarding_list.dart';
import 'package:se7ety_117/features/introduction/presentation/view/welcome.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController indicatorController = PageController();
  int pageIndex = 0 ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: AppBar(
            backgroundColor: AppColors.white,
            actions: [
              if(pageIndex!=2)
              TextButton(
                  onPressed: () {
                    pushWithReplacement(context,const WelcomeView());
                  },
                  child: Text(
                    'تخطي',
                    style: getBodyStyle(color: AppColors.primary),
                  )),
            ],
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
           // Spacer(),
            Expanded(
              child: PageView.builder(
                onPageChanged:(value) {
                  setState(() {
                    pageIndex=value;
                  });
                }, 
                controller: indicatorController,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SvgPicture.asset(
                        onboardingList[index].svgPicture,
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                     const Gap(20),
                      Text(
                        onboardingList[index].title,
                        style: getTitleStyle(),
                      ),
                      const Gap(20),
                      Text(
                        textAlign: TextAlign.center,
                        onboardingList[index].description,
                        style: getBodyStyle(color: AppColors.black),
                      ),
                    ],
                  );
                },
                itemCount: onboardingList.length,
              ),
            ),
            SizedBox(
              height: 65,
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: indicatorController,
                    count: 3,
                    effect: const WormEffect(
                        activeDotColor: AppColors.primary,
                        dotColor: AppColors.grey,
                        dotHeight: 12,
                        dotWidth: 14),
                  ),
                  const Spacer(),
                  if(pageIndex ==2)
                  CustomElevatedButton(text: 'هيا بنا',onPressed: (){
                    pushWithReplacement(context,const WelcomeView());
                  },),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

