import 'package:flutter/material.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/doctor/History/presentation/widgets/appoinments_summary.dart';

class AppoinmentsShedulesView extends StatelessWidget {
  const AppoinmentsShedulesView({
    super.key,
    required this.title, required this.isComplete, required this.doctorEmail,
  });
  final String title;
  final bool isComplete;
  final String doctorEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            AppoinmentSummary(isComplete:isComplete ,doctorEmail: doctorEmail,),
          ],
        ),
      ),
    );
  }
}
