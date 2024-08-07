import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_icons.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/doctor_card.dart';

class DoctorSearchResultsView extends StatelessWidget {
  const DoctorSearchResultsView({super.key, required this.search});

  final String search;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: AppColors.white,
          ),
          onPressed: () {
            pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'نتائج البحث',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("doctors")
            .orderBy("name")
            .startAt([search]).endAt(["$search\uf8ff"]).snapshots(),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
              : Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: doctors.length,
                          itemBuilder: (context, index) {
                            //
                            if (doctors[index]['image'] == "" ||
                                doctors[index]['specialization'] == "" ||
                                doctors[index]['phone1'] == "") {
                              return const SizedBox();
                            }

                            return DoctorCard(
                              name: doctors[index]["name"],
                              image: doctors[index]["image"],
                              rating: doctors[index]["rating"],
                              specialization: doctors[index]["specialization"],
                                doctorEmail: doctors[index]["email"],
                            );
                          }),
                    ],
                  ),
                );
        },
      ),
    );
  }
}


// Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           children: [
//             
//           ],
//         ),
//       );