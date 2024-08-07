import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  User? user;
  List labelName = [
    "الاسم",
    "رقم الهاتف",
    "المدينة",
    "نبذة تعريفية",
    "العمر",
  ];
  List labelvalue = [
    "name",
    "phone",
    "city",
    "bio",
    "age",
  ];
  var formKey = GlobalKey<FormState>();

  Future<void> getCurrentUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

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
          'اعدادات الحساب',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("patients")
            .doc(user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var person = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: labelName.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              //  barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                var valueController = TextEditingController(
                                    text: person[labelvalue[index]] == ""
                                        ? "لم تضاف"
                                        : person[labelvalue[index]]);
                                return SimpleDialog(
                                  contentPadding: const EdgeInsets.all(20),
                                  children: [
                                    Form(
                                      key: formKey,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "ادخل ${labelName[index]}",
                                            style: getBodyStyle(),
                                          ),
                                          const Gap(10),
                                          TextFormField(
                                            controller: valueController,
                                            decoration: const InputDecoration(
                                              fillColor: AppColors.white,
                                              filled: true,
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "من فضلك ادخل ${labelName[index]}";
                                              } else if (value.length != 11 &&
                                                  labelvalue[index] ==
                                                      "phone") {
                                                return "الرقم غير صحيح";
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomElevatedButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                updateUserData(
                                                  key: labelvalue[index],
                                                  value: valueController.text,
                                                );
                                              }
                                            },
                                            text: "حفظ التعديل",
                                            width: double.infinity,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.textFormFieldbg,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  labelName[index],
                                  style: getBodyStyle(),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: Text(
                                    person[labelvalue[index]] == ""
                                        ? "لم تضاف"
                                        : person[labelvalue[index]],
                                    style: getBodyStyle(
                                        fontWeight: FontWeight.w500),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
          //
        },
      ),
    );
  }

  Future<void> updateUserData({
    required String key,
    required String value,
  }) async {
    FirebaseFirestore.instance.collection("patients").doc(user!.uid).update({
      key: value,
    });
    if (key.compareTo("name") == 0) {
      await user!.updateDisplayName(value);
    }
    // ignore: use_build_context_synchronously
    pop(context);
  }
}
