import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_icons.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: const Icon(
          Icons.notifications_active,
          color: AppColors.black,
        ),
        centerTitle: true,
        title: Text(
          'صـحّـتـي',
          style: getTitleStyle(color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(
                  ' ,مرحبا',
                  style: getBodyStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'آيه راضي',
                  style: getBodyStyle(
                      fontWeight: FontWeight.w600, color: AppColors.primary),
                ),
              ],
            ),
            const Text(
              'احجز الآن وكن جزءًا من رحلتك الصحية.',
              style: TextStyle(
                fontSize: 25,
              ),
              textDirection: TextDirection.rtl,
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: AppColors.textFormFieldbg,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ابحث عن دكتور',
                    style: getSmallStyle(color: AppColors.black, fontSize: 16),
                  ),
                  FloatingActionButton(
                    backgroundColor: AppColors.primary,
                    onPressed: () {},
                    child: const Icon(
                      Icons.search,
                      color: AppColors.white,
                    ),
                  )
                ],
              ),
            ),
            Text(
              'التخصصات',
              style: getBodyStyle(color: AppColors.primary),
              textDirection: TextDirection.rtl,
            ),
            const Gap(10),
            /////////////////////////////////////////////////////////////////////////
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                separatorBuilder: (context, index) {
                  return const Gap(25);
                },
                itemBuilder: (context, index) {
                  return Container(
                      width: 160,
                      decoration: BoxDecoration(
                        color: (index == 0)
                            ? AppColors.mintGreen.withOpacity(0.70)
                            : (index == 1)
                                ? AppColors.primary.withOpacity(0.5)
                                : (index == 2)
                                    ? AppColors.orange.withOpacity(0.70)
                                    : (index == 3)
                                        ? AppColors.mintGreen.withOpacity(0.70)
                                        : AppColors.blue.withOpacity(0.70),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        alignment:  Alignment.center,
                        //AlignmentGeometry.lerp(, b, 2.75) ,
                        //  const Alignment(BorderSide.strokeAlignOutside,-2.57),
                        //Alignment Geometry,
                        children: [
                          Positioned(
                            top: -20,
                            right: -20,
                            child: CircleAvatar(
                              backgroundColor: AppColors.white.withOpacity(0.35),
                              radius: 70,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  width: 150,
                                  //alignment: Alignment.center,
                                  AssetsIcons.findDoctor,
                                ),
                                (index == 4)
                                    ? Text(
                                        'دكتور عظام',
                                        style:
                                            getBodyStyle(color: AppColors.white),
                                      )
                                    : (index == 3)
                                        ? Text(
                                            'دكتور قلب',
                                            style: getBodyStyle(
                                                color: AppColors.white),
                                          )
                                        : (index == 2)
                                            ? Text(
                                                'جراحة عامة',
                                                style: getBodyStyle(
                                                    color: AppColors.white),
                                              )
                                            : (index == 1)
                                                ? Text(
                                                    'دكتور مناعة',
                                                    style: getBodyStyle(
                                                        color: AppColors.white),
                                                  )
                                                : Text(
                                                    'دكتور جلدية',
                                                    style: getBodyStyle(
                                                        color: AppColors.white),
                                                  ),
                              ],
                            ),
                          ),
                        ],
                      ));
                },
              ),
            ),
            const Gap(20),
///////////////////////////////////////////////////////////////////
            Text(
              'الأعلى تقييماً',
              style: getBodyStyle(color: AppColors.primary),
              textDirection: TextDirection.rtl,
            ),
            const Gap(15),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.textFormFieldbg,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Container(
                    height: 65,
                    width: 55,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Image.asset(AssetsImages.user),
                  ),
                  const Gap(10),
                  Column(
                    children: [
                      Text(
                        'علي زين خالد',
                        style: getBodyStyle(color: AppColors.primary),
                      ),
                      const Gap(3),
                      Text(
                        'جراحة عامة',
                        style: getSmallStyle(color: AppColors.black),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      const Text('5'),
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade700,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
