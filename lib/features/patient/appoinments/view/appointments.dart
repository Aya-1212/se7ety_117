//
import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/patient/appoinments/view/pending_appoinment_list.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "مواعيد الحجز",
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: const PendingAppoinmentsList(),
    );
  }
}
