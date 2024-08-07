import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/features/doctor/settings/views/update_doctor_information.dart';
import 'package:se7ety_117/features/introduction/presentation/view/splash.dart';
import 'package:se7ety_117/features/patient/profile/presentation/widgets/personal_setting_options.dart';

class DoctorProfileSettings extends StatefulWidget {
  const DoctorProfileSettings({super.key});

  @override
  State<DoctorProfileSettings> createState() => _DoctorProfileSettingsState();
}

class _DoctorProfileSettingsState extends State<DoctorProfileSettings> {
  User? user;

  Future<void> getCurrentUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الاعدادات',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            PersonalSettingsWidget(
              onTap: () {
                  push(context, const UpdateDoctorInformations());
              },
              settingIcon: const Icon(
                Icons.person,
                color: AppColors.black,
              ),
              settingText: "اعدادات الحساب",
            ),
            PersonalSettingsWidget(
              onTap: () {},
              settingIcon: const Icon(
                Icons.password_sharp,
                color: AppColors.black,
              ),
              settingText: "كلمة السر",
            ),
            PersonalSettingsWidget(
              onTap: () {},
              settingIcon: const Icon(
                Icons.notifications_active,
                color: AppColors.black,
              ),
              settingText: "اعدادات الاشعارات",
            ),
            PersonalSettingsWidget(
              onTap: () {},
              settingIcon: const Icon(
                Icons.security_outlined,
                color: AppColors.black,
              ),
              settingText: "الخصوصية",
            ),
            PersonalSettingsWidget(
              onTap: () {},
              settingIcon: const Icon(
                Icons.question_mark_sharp,
                color: AppColors.black,
              ),
              settingText: "المساعدة و الدعم",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: CustomElevatedButton(
          onPressed: () {
            signOut();
            pushAndRemoveUntil(context, const SplashView());
          },
          text: "تسجيل الخروج",
          backgroundColor: Colors.redAccent,
          width: double.infinity,
          padding: const EdgeInsets.all(5),
        ),
      ),
    );
  }

}
