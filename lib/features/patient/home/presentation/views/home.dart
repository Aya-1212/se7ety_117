// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/patient/home/presentation/widgets/category_list.dart';
import 'package:se7ety_117/features/patient/home/presentation/widgets/top_rating_list.dart';
import 'package:se7ety_117/features/patient/search/presentation/views/doctor_search_results_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  User? user;
  var searchController = TextEditingController();
  Future<void> getCurrentUser() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
    // ();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'صـحّـتـي',
          style: getTitleStyle(color: AppColors.black),
        ),
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.notifications_active,
              size: 28,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text.rich(
              TextSpan(children: [
                TextSpan(
                  text: "مرحبا,",
                  style: getBodyStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: " ${user!.displayName}",
                  style: getBodyStyle(
                      fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ]),
            ),

            Text(
              'احجز الآن وكن جزءًا من رحلتك الصحية.',
              style: getTitleStyle(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              padding: const EdgeInsets.all(6),
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.textFormFieldbg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: searchController,
                style: getBodyStyle(),
                decoration: InputDecoration(
                  hintText: 'ابحث عن دكتور',
                  hintStyle:
                      getSmallStyle(color: AppColors.black, fontSize: 16),
                  suffixIcon: FloatingActionButton(
                    backgroundColor: AppColors.primary,
                    onPressed: () {
                      searchController.text == ""
                          ? Container()
                          : push(
                              context,
                              DoctorSearchResultsView(
                                search: searchController.text,
                              ));
                      searchController.text = "";
                    },
                    child: const Icon(
                      Icons.search,
                      color: AppColors.white,
                    ),
                  ),
                ),
                textInputAction: TextInputAction.search,
                //on field Submiited
                onFieldSubmitted: (doctorName) {
                  doctorName == ""
                      ? Container()
                      : push(
                          context,
                          DoctorSearchResultsView(
                            search: searchController.text,
                          ));
                  searchController.text = "";
                },
              ),
            ),
            /////////////-----<<specialization>>------------//////////////////////////
            const CategoryBanner(),
            const Gap(20),
///////////////////////////////////////////////////////////////////
            // Lottie.asset("assets/doctor_lottie.json",
            //     height: 250, width: 200, fit: BoxFit.cover),

            Text(
              'الأعلى تقييماً',
              style: getBodyStyle(color: AppColors.primary),
              textDirection: TextDirection.rtl,
            ),
            const TopRatingDoctorsList(),
          ],
        ),
      ),
    );
  }
}
