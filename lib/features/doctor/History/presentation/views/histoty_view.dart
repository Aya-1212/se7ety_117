import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/doctor/History/presentation/views/appoinment_schedules_view.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "المواعيد السابقه",
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    push(
                      context,
                      AppoinmentsShedulesView(
                        title: index == 0
                            ? "المواعيد المكتملة"
                            : "المواعيد الغير المكتملة",
                        isComplete: index == 0 ? true : false,
                        doctorEmail: user!.email!,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColors.textFormFieldbg,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      index == 0
                          ? "المواعيد المكتملة"
                          : "المواعيد الغير المكتملة",
                      style: TextStyle(
                        color: index == 0 ? AppColors.primary : Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
