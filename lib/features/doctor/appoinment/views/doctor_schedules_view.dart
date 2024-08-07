import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/doctor/appoinment/views/pending_doctor_schedule.dart';

class DoctorSchedulesView extends StatelessWidget {
  const DoctorSchedulesView({super.key});

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
      body:const PendingDoctorScheduleList() ,
    );
  }
}