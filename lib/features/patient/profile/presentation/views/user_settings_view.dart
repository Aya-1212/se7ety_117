import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/features/introduction/presentation/view/splash.dart';
import 'package:se7ety_117/features/patient/profile/presentation/views/update_password_view.dart';
import 'package:se7ety_117/features/patient/profile/presentation/views/update_profile_view.dart';
import 'package:se7ety_117/features/patient/profile/presentation/widgets/personal_setting_options.dart';

class UserSettingsView extends StatefulWidget {
  const UserSettingsView({super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
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
          'الاعدادات',
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // const  Icon(Icons.person, color: AppColors.black,),
            PersonalSettingsWidget(
              onTap: () {
                push(context, const UpdateProfileView());
              },
              settingIcon: const Icon(
                Icons.person,
                color: AppColors.black,
              ),
              settingText: "اعدادات الحساب",
            ),
            PersonalSettingsWidget(
              onTap: () {
                push(context, const UpdatePasswordView());
              },
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
               PersonalSettingsWidget(
              onTap: () {},
              settingIcon: const Icon(
                Icons.person_add_alt_1,
                color: AppColors.black,
              ),
              settingText: "دعوة صديق",
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
