import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/patient/search/presentation/views/doctor_profile_view.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.name,
    required this.image,
    required this.specialization,
    required this.rating,
    required this.doctorEmail,
  });

  final String name;
  final String image;
  final String specialization;
  final String rating;
  final String doctorEmail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(
            context,
            DoctorProfileView(
              doctorEmail: doctorEmail,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: AppColors.textFormFieldbg,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(-3, 0),
              blurRadius: 15,
              color: Colors.grey.withOpacity(.1),
            )
          ],
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                height: 60,
                width: 65,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child:
                 Image.network(
                  image,
                  fit: BoxFit.contain,
                  width: 60,
                  height: 65,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.error_outline),
                  ),
                ),
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                children: [
                  Text(
                    name,
                    style: getBodyStyle(color: AppColors.primary),
                  ),
                  const Gap(3),
                  Text(
                    specialization,
                    style: getSmallStyle(color: AppColors.black),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(rating),
                Icon(
                  Icons.star,
                  color: Colors.yellow.shade700,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
