// ignore_for_file: annotate_overrides, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/services/app_local_storage.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/features/doctor/doctor_app_view.dart';
import 'package:se7ety_117/features/introduction/presentation/view/onboarding/onboarding_view.dart';
import 'package:se7ety_117/features/patient/patient_app_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // ignore: must_call_super
  void initState() {
    Future.delayed(
      Duration(seconds: 8),
      () {
        pushWithReplacement(
            context,
            FirebaseAuth.instance.currentUser != null &&
                    AppLocalStorage.getData("isDoctor") == false
                ? PatenitAppView()
                : FirebaseAuth.instance.currentUser != null &&
                        AppLocalStorage.getData("isDoctor") == true
                    ? DoctorAppView()
                    : OnboardingView());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsImages.sa7atyLogo),
          ],
        ),
      ),
    );
  }
}
