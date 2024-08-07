// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';

class UpdatePasswordView extends StatefulWidget {
  const UpdatePasswordView({super.key});

  @override
  State<UpdatePasswordView> createState() => _UpdatePasswordViewState();
}

class _UpdatePasswordViewState extends State<UpdatePasswordView> {
  var formKey = GlobalKey<FormState>();

  var passwordController = TextEditingController();

  bool obscureText = true;

  User? user;

  Future<void> getCurrentUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  Future<void> changePassword() async {
    await user!.updatePassword(passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          'تغيير كلمة المرور',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ادخل كلمة المرور الجديدة",
                style: getBodyStyle(fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              TextFormField(
                style: getBodyStyle(),
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.black,
                    ),
                    hintText: "*******",
                    hintStyle: getBodyStyle(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: obscureText == true
                            ? const Icon(
                                Icons.remove_red_eye_outlined,
                                color: AppColors.black,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: AppColors.primary,
                              ))),
                controller: passwordController,
                obscureText: obscureText,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "الرجاء ادخال كلمة المرور";
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.center,
                child: CustomElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      changePassword();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "تم تغيير كلمة المرور بنجاح",
                            style: getBodyStyle(color: AppColors.white),
                          ),
                          backgroundColor: AppColors.primary,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      pop(context);
                    }
                  },
                  text: "تغيير كلمة المرور",
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
