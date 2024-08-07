import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/core/widgets/empty_pending_appoinments.dart';

class PendingAppoinmentsList extends StatefulWidget {
  const PendingAppoinmentsList({super.key});

  @override
  State<PendingAppoinmentsList> createState() => _PendingAppoinmentsListState();
}

class _PendingAppoinmentsListState extends State<PendingAppoinmentsList> {
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  showDeleteDialog(context, String documentId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: Text(
            "هل تريد مسح هذا الحجز",
            style: getBodyStyle(),
          ),
          content: Row(
            children: [
              TextButton(
                onPressed: () {
                  deleteAppoinment(documentId);
                  pop(context);
                },
                child: Text(
                  "نعم",
                  style: getBodyStyle(),
                ),
              ),
              TextButton(
                onPressed: () {
                  pop(context);
                },
                child: Text(
                  "لا",
                  style: getBodyStyle(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  deleteAppoinment(String docId) {
    FirebaseFirestore.instance
        .collection("appoinment")
        .doc("appoinments")
        .collection("pending")
        .doc(docId)
        .delete();
  }

  checkDiff(Timestamp date) {
    var diff = DateTime.now()
        .difference(DateTime.parse(date.toDate().toString()))
        .inHours;
    if (diff > 2) {
      return true;
    }
    return false;
  }

  isToday(Timestamp date) {
    var diff = DateTime.now()
        .difference(DateTime.parse(date.toDate().toString()))
        .inDays;
    if (diff > 0) {
      return true;
    }
    return false;
  }

  dateFormatter(Timestamp date) {
    String formattedDate = DateFormat("dd-MM-yyyy")
        .format(DateTime.parse(date.toDate().toString()));
    return formattedDate;
  }

  timeFormatter(Timestamp date) {
    String formattedTime =
        DateFormat("hh:mm").format(DateTime.parse(date.toDate().toString()));
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("appoinment")
          .doc("appoinments")
          .collection("pending")
          .where("patientId", isEqualTo: user!.email)
          .orderBy("date", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return snapshot.data!.docs.isEmpty
            ? const EmptyPendingAppoinments()
            : Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 10,
                  right: 10,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          var document = snapshot.data!.docs[index];
                          if (checkDiff(document["date"])) {
                            deleteAppoinment(document.id);
                          }
                          return Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            decoration: BoxDecoration(
                                color: AppColors.textFormFieldbg,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.5),
                                    blurRadius: 20,
                                    offset: const Offset(4, 4),
                                  ),
                                ]),
                            child: ExpansionTile(
                              collapsedIconColor: AppColors.primary,
                              title: Text(
                                document["doctor"],
                                style: getBodyStyle(color: AppColors.primary),
                              ),
                              backgroundColor: AppColors.textFormFieldbg,
                              collapsedBackgroundColor:
                                  AppColors.textFormFieldbg,
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.date_range,
                                        color: AppColors.primary,
                                      ),
                                      const Gap(10),
                                      Text(
                                        dateFormatter(document["date"]),
                                        style: getBodyStyle(),
                                      ),
                                      const Gap(15),
                                      Text(
                                        isToday(document["date"])
                                            ? "اليوم"
                                            : "",
                                        style: getBodyStyle(
                                            color: AppColors.primary),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time_rounded,
                                        color: AppColors.primary,
                                      ),
                                      const Gap(10),
                                      Text(
                                        timeFormatter(document["date"]),
                                        style: getBodyStyle(),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "اسم المريض: ",
                                              style: getBodyStyle(),
                                            ),
                                            TextSpan(
                                              text: document["name"],
                                              style: getBodyStyle(),
                                            ),
                                          ],
                                        ), //
                                      ),
                                      const Gap(2),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_rounded,
                                            color: AppColors.primary,
                                          ),
                                          const Gap(10),
                                          Text(
                                            document["location"],
                                            style: getBodyStyle(),
                                          ),
                                        ],
                                      ),
                                      const Gap(10),
                                      CustomElevatedButton(
                                        width: double.infinity,
                                        onPressed: () {
                                          showDeleteDialog(context,document.id);
                                        },
                                        text: "حذف",
                                        backgroundColor: Colors.red,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
