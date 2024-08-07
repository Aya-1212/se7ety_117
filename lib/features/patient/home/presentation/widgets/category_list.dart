import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_icons.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/authorization/data/specialization_list.dart';
import 'package:se7ety_117/features/patient/home/data/card_model.dart';
import 'package:se7ety_117/features/patient/home/presentation/views/explore_list_view.dart';

class CategoryBanner extends StatelessWidget {
  const CategoryBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            itemCount: specializationList.length,
            separatorBuilder: (context, index) {
              return const Gap(25);
            },
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  push(
                      context,
                      ExploreListView(
                        doctorSpecializtion: specializationList[index],
                      ));
                },
                child: CategoryCard(
                  color1: cardColors[index].color1,
                  color2: cardColors[index].color2,
                  specialization: specializationList[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.specialization,
    required this.color1,
    required this.color2,
  });
  final String specialization;
  final Color color1;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            color: color1,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: color2.withOpacity(0.8),
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ]),
        child: Stack(
          children: [
            Positioned(
              top: -20,
              right: -20,
              child: CircleAvatar(
                backgroundColor: AppColors.white.withOpacity(0.35),
                radius: 60,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: SvgPicture.asset(
                      AssetsIcons.findDoctor,
                    ),
                  ),
                  const Gap(10),
                  Flexible(
                    child: Text(
                      specialization,
                      style: getBodyStyle(color: AppColors.white),
                    ),
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ],
        ));
  }
}
