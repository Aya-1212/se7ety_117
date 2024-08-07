
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class AllAppoinments extends StatelessWidget {
  const AllAppoinments(
      {super.key,
      required this.useremail,
      required this.whereKey,
      required this.isDoctor,
      });
  final String whereKey;
  final String useremail;
  final bool isDoctor;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("appoinment")
          .doc("appoinments")
          .collection("all")
          .where(whereKey, isEqualTo: useremail) //key//email
          .orderBy("date", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data!.docs.isEmpty
            ? Center(
                child: Text(
                  "لا توجد حجوزات ",
                  style: getBodyStyle(),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.size,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.textFormFieldbg,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            document["iscomplete"]
                                ? "الحجز مكتمل"
                                : "الحجز غير مكتمل",
                            style: TextStyle(
                              color: document["iscomplete"]
                                  ? AppColors.primary
                                  : Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: isDoctor == false ? "د/  " : "اسم المريض: ",
                                style: getBodyStyle(color: AppColors.primary),
                              ),
                              TextSpan(
                                text: isDoctor == false ? document["doctor"] : document["name"]  ,
                                style: getBodyStyle(color: AppColors.primary),
                              ),
                            ],
                          ), //
                        ),
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
                  );
                },
              );
      },
    );
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
}
