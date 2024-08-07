import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/features/patient/patient_app_view.dart';
import 'package:se7ety_117/features/patient/search/data/doctor_model.dart';
import 'package:se7ety_117/features/patient/search/data/get_available_times.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key, required this.doctor});

  final Doctor doctor;

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();
  String bookingTime = "00:00";
  var patientStatusController = TextEditingController();
  //MM month(1,2,3) MMM month(jan,feb,mar)
  String bookingDate = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String? dateStored;
  int selectedChip = -1;

  List<int> times = [];
  getAvailableTime(selectedDate) async {
    times.clear();
    AppointmentsServices()
        .availableAppoinmentsTimes(
      dateSelected: selectedDate,
      openHour: widget.doctor.openHour,
      endHour: widget.doctor.closeHour,
    )
        .then((value) {
      for (var i in value) {
        times.add(i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: AppColors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "احجز مع دكتورك",
          style: getTitleStyle(color: AppColors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColors.textFormFieldbg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: widget.doctor.image == ""
                              ? AssetImage(AssetsImages.user)
                              : NetworkImage(widget.doctor.image)
                                  as ImageProvider,
                        ),
                        const Gap(15),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "د. ${widget.doctor.name}",
                                style: getTitleStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.doctor.specialization,
                                style: getBodyStyle(),
                              ),
                              Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: widget.doctor.rating,
                                      style: getBodyStyle()),
                                  const WidgetSpan(
                                    child: Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Positioned(
                      bottom: -12,
                      left: -10,
                      child: Icon(
                        Icons.access_time_rounded,
                        color: AppColors.white,
                        size: 80,
                      )),
                ],
              ),
              //////////////////////////////////////////////////////////////////////////////////////////////////////
              const Gap(15),
              Text(
                "--ادخل بيانات الحجز--",
                style: getTitleStyle(),
              ),
              const Gap(15),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "اسم المريض",
                        style: getBodyStyle(),
                      ),
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل الاسم";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'رقم الهاتف',
                        style: getBodyStyle(),
                      ),
                    ),
                    TextFormField(
                      controller: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل رقم الهاتف";
                        } else if (value.length != 11) {
                          return "ادخل رقم صحيح";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "وصف الحاله",
                        style: getBodyStyle(),
                      ),
                    ),
                    TextFormField(
                      maxLines: 5,
                      controller: patientStatusController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "ادخل وصف الحاله";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "تاريخ الحجز",
                        style: getBodyStyle(),
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: bookingDate,
                        hintStyle: getBodyStyle(color: AppColors.black),
                        suffixIcon: CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: IconButton(
                              onPressed: () {
                                selectedDate(context);
                              },
                              icon: const Icon(
                                Icons.calendar_month_outlined,
                                color: AppColors.white,
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "وقت الحجز",
                        style: getBodyStyle(),
                      ),
                    ),
                    times.isNotEmpty
                        ? Wrap(
                            spacing: 8,
                            children: List.generate(
                              times.length,
                              (index) => ChoiceChip(
                                checkmarkColor: AppColors.primary,
                                label: Text(
                                  '${(times[index] < 10) ? '0' : ''}${times[index].toString()}:00',
                                  style: TextStyle(
                                    color: index == selectedChip
                                        ? AppColors.black
                                        : AppColors.white,
                                  ),
                                ),
                                selected: index == selectedChip,
                                backgroundColor: AppColors.primary,
                                selectedColor: AppColors.mintGreen,
                                onSelected: (_) {
                                  setState(() {
                                    selectedChip = index;
                                    bookingTime =
                                        '${(times[index] < 10) ? '0' : ''}${times[index].toString()}:00';
                                  });
                                },
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                "لا يوجد مواعيد للدكتور اليوم",
                                style: getBodyStyle(),
                              ),
                            ),
                          ),
                    //
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 5,
          left: 5,
        ),
        child: CustomElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate() && bookingTime != "00:00") {
                createAppoinment();
                showDialog(
                  context: context,
                  barrierDismissible: false ,
                  builder: (context) {
                    return SimpleDialog(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "تم حجز الدكتور بنجاح",
                                style: getBodyStyle(),
                              ),
                              const Gap(25),
                              CustomElevatedButton(
                                width: double.infinity,
                                onPressed: () {
                                  pushAndRemoveUntil(
                                      context, const PatenitAppView());
                                },
                                text: "اضغظ للانتقال",
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                );
              }
            },
            text: "حجز الدكتور"),
      ),
    );
  }

  Future<void> createAppoinment() async {
    FirebaseFirestore.instance
        .collection("appoinment")
        .doc("appoinments")
        .collection("all")
        .doc()
        .set({
      "doctorId": widget.doctor.email,
      "patientId": user!.email,
      "doctor": widget.doctor.name,
      "name": nameController.text,
      "date": DateTime.parse("$dateStored $bookingTime"),
      "location": widget.doctor.address,
      "description": patientStatusController.text,
      "phone": phoneController.text,
      "iscomplete": false,
      "rating": "",
    }, SetOptions(merge: true));
    //
    FirebaseFirestore.instance
        .collection("appoinment")
        .doc("appoinments")
        .collection("pending")
        .doc()
        .set({
      "doctorId": widget.doctor.email,
      "patientId": user!.email,
      "doctor": widget.doctor.name,
      "name": nameController.text,
      "date": DateTime.parse("$dateStored $bookingTime"),
      "location": widget.doctor.address,
      "description": patientStatusController.text,
      "phone": phoneController.text,
      "iscomplete": false,
      "rating": "",
    }, SetOptions(merge: true));
  }

  Future<void> selectedDate(context) async {
    //TimePicker
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((value) {
      if (value != null) {
        setState(() {
          //  print(bookingDate);
          bookingDate = DateFormat("dd-MM-yyyy").format(value);
          // print(bookingDate);
          dateStored = DateFormat("yyyy-MM-dd").format(value);
          // print(value);
          getAvailableTime(value);
        });
      }
    });
  }
}
