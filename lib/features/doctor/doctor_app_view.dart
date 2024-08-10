import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/doctor/History/presentation/views/histoty_view.dart';
import 'package:se7ety_117/features/doctor/appoinment/views/doctor_schedules_view.dart';
import 'package:se7ety_117/features/doctor/profile/views/doctor_personal_profile.dart';
import 'package:se7ety_117/features/doctor/settings/views/doctor_profile_settings.dart';

class DoctorAppView extends StatefulWidget {
  const DoctorAppView({super.key});

  @override
  State<DoctorAppView> createState() => _DoctorAppViewState();
}

class _DoctorAppViewState extends State<DoctorAppView> {
  List<Widget> naviViews = [
    const DoctorSchedulesView(),
    const HistoryView(),
    const DoctorpersonalProfile(),
    const DoctorProfileSettings(),
  ];
  int index = 0;
  Color selectedcolor = AppColors.primary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              blurRadius: 20,
            ),
          ],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: GNav(
            curve: Curves.easeInOutExpo,
            activeColor: AppColors.white,
            color: AppColors.black,
            iconSize: 28,
            selectedIndex: index,
            gap: 5,
            duration: const Duration(milliseconds: 400),
            tabBorderRadius: 15,
            textStyle: getBodyStyle(color: AppColors.white),
            backgroundColor: AppColors.white,
            onTabChange: (value) {
              setState(() {
                index = value;
              });
            },
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            haptic: true,
            hoverColor: AppColors.grey,
            rippleColor: AppColors.grey,
            tabBackgroundColor: AppColors.primary,
            tabs: const [
              GButton(
                icon: Icons.work_history_rounded,                
                text: 'العمل',
              ),
              GButton(
                icon: Icons.calendar_month_outlined,
                text: "المواعيد",
              ),
              GButton(
                icon: Icons.person,
                text: 'الحساب',
              ),
              GButton(
                icon: Icons.settings,
                text: 'الاعدادات',
              ),
            ]),
      ),
      body: naviViews[index],
    );
  }
}
