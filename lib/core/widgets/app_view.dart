import 'package:cuberto_bottom_bar/cuberto_bottom_bar.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
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
    const HomeView(),
    const SearchView(),
    const AppointmentsView(),
    const AccountView(),
  ];
  int index = 0;
  Color selectedcolor = AppColors.primary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        height: 100,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.black, offset: Offset(5, 5), spreadRadius: 0.5)
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: GNav(
            activeColor: AppColors.white,
            color: AppColors.black,
            iconSize: 28,
            selectedIndex: index,
            // backgroundColor: ,
            onTabChange: (value) {
              setState(() {
                index = value;
              });
            },
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


// SizedBox(
//         height: 70,
//         child: CubertoBottomBar(
//           key: const Key("BottomBar"),
//           tabStyle: CubertoTabStyle.styleNormal,
//           inactiveIconColor: AppColors.black,
//           selectedTab: index,
//           padding: const EdgeInsets.all(15),
//           tabColor: selectedcolor,
//           tabs: [
//             TabData(
//               iconData: ,
//               title: '',
//               tabColor: AppColors.white,
//             ),
//             TabData(
//               title: '',
//               iconData: ,
//               tabColor: AppColors.white,
//             ),
//             TabData(
//               iconData: ,
//               title: '',
//               tabColor: AppColors.white,
//             ),
//             TabData(
//               iconData: Icons.home,
//               title: '',
//             ),
//           ],
//           onTabChangedListener: (position, title, tabColor) {
//             setState(() {
//               index = position;
//               indexText = title;
//               if (tabColor != null) {
//                 tabColor = selectedcolor;
//               }
//             });
//           },
//         ),
//       ),