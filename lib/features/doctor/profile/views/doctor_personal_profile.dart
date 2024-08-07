import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/all_appoinments.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/core/widgets/tile_widget.dart';
import 'package:se7ety_117/features/doctor/settings/views/update_doctor_information.dart';

class DoctorpersonalProfile extends StatefulWidget {
  const DoctorpersonalProfile({super.key});

  @override
  State<DoctorpersonalProfile> createState() => _DoctorpersonalProfileState();
}

class _DoctorpersonalProfileState extends State<DoctorpersonalProfile> {
  User? user;
  String? image;
  File? imageFile;
  String? profileImage;

  Future<void> getCurrentUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  Future<String> uploadImageToFireStorage({required File image}) async {
    // مكان التخزين
    Reference ref =
        FirebaseStorage.instanceFor(bucket: "gs://se7ety-117-8ceaa.appspot.com")
            .ref()
            .child("doctors/${user!.uid}");
//نوع الصوره
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(image, metadata);
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> updateProfileImage() async {
    final imagePicked =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      setState(() {
        image = imagePicked.path;
        imageFile = File(imagePicked.path);
      });
    }
    profileImage = await uploadImageToFireStorage(image: imageFile!);
    FirebaseFirestore.instance.collection("doctors").doc(user!.uid).set({
      "image": profileImage,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الحساب الشخصي",
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("doctors")
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var person = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: person!["image"] == ""
                                ? AssetImage(
                                    AssetsImages.user,
                                  )
                                : NetworkImage(person["image"])
                                    as ImageProvider,
                          ),
                          Positioned(
                            bottom: 6,
                            right: 0,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.white,
                              child: IconButton(
                                onPressed: () async {
                                  await updateProfileImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.primary,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(30),
                      Column(
                        children: [
                          Text(
                            person["name"],
                            style: getTitleStyle(),
                          ),
                          const Gap(10),
                          person["specialization"] == ""
                              ? CustomElevatedButton(
                                  onPressed: () {
                  push(context, const UpdateDoctorInformations());
                                  },
                                  text: "تعديل",
                                )
                              : Text(
                                  person["specialization"],
                                  style: getBodyStyle(),
                                ),
                        ],
                      )
                    ],
                  ),
                  const Gap(20),
                  Text(
                    "نبذة تعريفية",
                    style: getBodyStyle(),
                  ),
                  const Gap(10),
                  Text(
                    person["bio"] == "" ? "لم تضاف" : person["bio"],
                    style: getBodyStyle(),
                  ),
                  const Gap(20),
                  const Divider(
                    color: AppColors.black,
                  ),
                  const Gap(20),
                  Text("معلومات التواصل", style: getBodyStyle()),
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
                          text: person["email"],
                        ),
                        const Gap(10),
                        TileWidget(
                          iconData: Icons.phone,
                          text: person["phone1"] == ""
                              ? "لم تضاف"
                              : person["phone1"],
                        ),
                        person["phone2"] != ""
                            ? Column(
                                children: [
                                  const Gap(10),
                                  TileWidget(
                                    iconData: Icons.phone,
                                    text: person["phone2"] == ""
                                        ? "لم تضاف"
                                        : person["phone2"],
                                  ),
                                ],
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  const Gap(20),
                  const Divider(
                    color: AppColors.black,
                  ),
                  const Gap(20),
                  Text(
                    "حجوزاتي",
                    style: getBodyStyle(),
                  ),
                  const Gap(10),
                  AllAppoinments(
                    isDoctor: true,
                    useremail: person["email"],
                    whereKey: "doctorId",
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
