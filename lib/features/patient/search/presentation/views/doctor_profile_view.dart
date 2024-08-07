// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/core/widgets/small_icon_tile.dart';
import 'package:se7ety_117/core/widgets/tile_widget.dart';
import 'package:se7ety_117/features/patient/search/data/doctor_model.dart';
import 'package:se7ety_117/features/patient/search/presentation/views/booking_view.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileView extends StatelessWidget {
  DoctorProfileView({super.key, required this.doctorEmail});

  final String doctorEmail;
  late Doctor doctorInformations;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "بيانات الدكتور",
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("doctors")
            .where("email", isEqualTo: doctorEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var doctor = snapshot.data!.docs[0];
          doctorInformations = Doctor(
            name: doctor["name"],
            image: doctor["image"],
            specialization: doctor["specialization"],
            rating: doctor["rating"],
            email: doctor["email"],
            address: doctor["address"],
            openHour: doctor["openHour"],
            closeHour: doctor["closeHour"],
          );
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        //AssetImage(AssetsImages.user:NetworkImage(doctor["image"])
                        radius: 70,
                        backgroundImage: doctor["image"] == ""
                            ? AssetImage(AssetsImages.user)
                            : NetworkImage(doctor["image"]) as ImageProvider,
                      ),
                      const Gap(30),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              doctor["name"],
                              style: getTitleStyle(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              doctor["specialization"],
                              style: getBodyStyle(),
                            ),
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text: "${doctor["rating"]}",
                                    style: getBodyStyle()),
                                const WidgetSpan(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ), //
                  /////////////////////////////////////////////////////////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmallIconTile(
                        icon: const Icon(
                          Icons.phone,
                          color: AppColors.black,
                        ),
                        text: "1",
                        onTap: () {
                          //urlLaun
                          launchUrl(
                            Uri.parse("tel://${doctor["phone1"]}"),
                          );
                        },
                      ),
                      const Gap(8),
                      doctor["phone2"] == ""
                          ? const SizedBox()
                          : SmallIconTile(
                              icon: const Icon(
                                Icons.phone,
                                color: AppColors.black,
                              ),
                              text: "2",
                              onTap: () {
                                launchUrl(
                                  Uri.parse("tel://${doctor["phone2"]}"),
                                );
                              },
                            ),
                    ],
                  ), //
                  const Gap(20),
                  Text(
                    "نبذة تعريفية",
                    style: getBodyStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Text(
                    doctor["bio"],
                    style: getBodyStyle(),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(20),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.textFormFieldbg,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        TileWidget(
                          iconData: Icons.access_time_rounded,
                          text:
                              "${doctor["openHour"]}:00-${doctor["closeHour"]}:00",
                        ),
                        const Gap(15),
                        TileWidget(
                          iconData: Icons.location_on,
                          text: doctor["address"],
                        ),
                      ],
                    ),
                  ),
                  //
                  const Gap(6),
                  const Divider(
                    color: AppColors.black,
                  ),
                  const Gap(15),
                  Text(
                    "معلومات الاتصال",
                    style: getBodyStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.textFormFieldbg,
                    ),
                    child: Column(
                      children: [
                        TileWidget(
                          iconData: Icons.email,
                          text: doctor["email"],
                        ),
                        const Gap(15),
                        TileWidget(
                          iconData: Icons.phone,
                          text: doctor["phone1"],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomElevatedButton(
          onPressed: () {
            push(
                context,
                BookingView(
                  doctor: doctorInformations,
                ));
          },
          text: "احجز موعد الان",
          height: 55,
        ),
      ),
    );
  }
}
