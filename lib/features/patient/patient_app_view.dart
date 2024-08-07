import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/patient/appoinments/view/appointments.dart';
import 'package:se7ety_117/features/patient/profile/presentation/views/user_profile_view.dart';
import 'package:se7ety_117/features/patient/home/presentation/views/home.dart';
import 'package:se7ety_117/features/patient/search/presentation/views/search.dart';

class PatenitAppView extends StatefulWidget {
  const PatenitAppView({super.key});

  @override
  State<PatenitAppView> createState() => _PatenitAppViewState();
}

class _PatenitAppViewState extends State<PatenitAppView> {
  String indexText = 'home';
  List<Widget> naviViews = [
    const HomeView(),
    const SearchView(),
    const AppointmentsView(),
    const UserProfileView(),
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
            //???
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
                icon: Icons.home_filled,
                text: 'الرئيسية',
              ),
              GButton(
                icon: Icons.search_rounded,
                text: 'البحث',
              ),
              GButton(
                icon: Icons.calendar_month_outlined,
                text: 'المواعيد',
              ),
              GButton(
                icon: Icons.person,
                text: 'الحساب',
              ),
            ]),
      ),
      body: naviViews[index],
    );
  }
}
