import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_icons.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/doctor_card.dart';

class ExploreListView extends StatelessWidget {
  const ExploreListView({super.key, required this.doctorSpecializtion});

  final String doctorSpecializtion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          doctorSpecializtion,
          style: getTitleStyle(color: AppColors.white),
        ),
        elevation: 0,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("doctors")
              .where("specialization", isEqualTo: doctorSpecializtion)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return snapshot.data!.docs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                  : Column(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              //list of doctors
                              var doctor = snapshot.data!.docs[index].data();
                              //one doctor
                            //  DocumentSnapshot doc = snapshot.data!.docs[index];
                              return DoctorCard(
                                image: doctor['image'],
                                name: doctor['name'],
                                rating: doctor['rating'],
                                specialization: doctor['specialization'],
                                doctorEmail: doctor["email"],
                              );
                            })
                      ],
                    );
            }
          },
        ),
      ),
    );
  }
}
