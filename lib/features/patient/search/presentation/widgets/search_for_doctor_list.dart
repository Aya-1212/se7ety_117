import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_icons.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/doctor_card.dart';

class SearchForDoctorList extends StatelessWidget {
  const SearchForDoctorList({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("doctors")
          .orderBy("name")
          .startAt([searchController.text]).endAt(
              ["${searchController.text}\uf8ff"]).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var doctors = snapshot.data!.docs;

        return snapshot.data!.docs.isEmpty
            ? Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      AssetsIcons.noSearch,
                      width: 250,
                    ),
                    const Gap(5),
                    Text(
                      "لا يوجد دكتور بهذا التخصص حاليا",
                      style: getBodyStyle(color: AppColors.primary),
                    )
                  ],
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                    //  padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      return DoctorCard(
                        name: doctors[index]["name"],
                        image: doctors[index]["image"],
                        rating: doctors[index]["rating"],
                        specialization: doctors[index]["specialization"],
                          doctorEmail: doctors[index]["email"],
                      );
                    }),
              );
      },
    );
  }
}
