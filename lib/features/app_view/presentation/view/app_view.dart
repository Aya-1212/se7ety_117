import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/features/app_view/presentation/view/account.dart';
import 'package:se7ety_117/features/app_view/presentation/view/appointments.dart';
import 'package:se7ety_117/features/app_view/presentation/view/home.dart';
import 'package:se7ety_117/features/app_view/presentation/view/search.dart';

class PatenitAppView extends StatefulWidget {
  const PatenitAppView({super.key});

  @override
  State<PatenitAppView> createState() => _PatenitAppViewState();
}

class _PatenitAppViewState extends State<PatenitAppView> {
  String indexText = 'home';
  List<Widget> naviViews = [
    const AccountView(),
    const AppointmentsView(),
    const SearchView(),
    const HomeView(),
  ];
  int index = 3;
  Color selectedcolor = AppColors.primary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: 
      SizedBox(
          height: 70,
          child: CubertoBottomBar(
          key: const Key("BottomBar"),
          tabStyle: CubertoTabStyle.styleNormal,
          inactiveIconColor: AppColors.black,
          selectedTab: index,
          padding: const EdgeInsets.all(15),
          tabColor: selectedcolor,
          tabs:[
            TabData(
                iconData: Icons.person,
                title: 'الحساب',
                tabColor: AppColors.white,
),
            TabData(
                title: 'المواعيد',
                iconData: Icons.calendar_month_outlined,
                tabColor: AppColors.white,
),
            TabData(
                iconData: Icons.search_rounded,
                title: 'البحث',
                tabColor: AppColors.white,
),
            TabData(
                iconData: Icons.home,
                title: 'الرئيسية',
),],
           onTabChangedListener: (position, title, tabColor) {
            setState(() {
              index = position;
              indexText = title;
              if (tabColor != null) {
                 tabColor = selectedcolor;
              }
            });
          },
        ),
      ), 
      body: naviViews[index],
    );
  }
}
