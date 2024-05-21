import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/custom_elevated.dart';
import 'package:se7ety_117/core/widgets/custorm_dialogs.dart';
import 'package:se7ety_117/features/authorization/data/specialization_list.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_cubit.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_states.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  String specialization = specializationList[0];
  var formKey = GlobalKey<FormState>();
  var bio = TextEditingController();
  var address = TextEditingController();
  var openHour = TextEditingController();
  var closeHour = TextEditingController();
  var phone1 = TextEditingController();
  var phone2 = TextEditingController();
  String? userID;
  String? pickedGalleryImage;
  File? file;
  String? imageUrl;
 late String endTime = DateFormat('hh').format(DateTime.now());
 late String openTime = DateFormat('hh').format(DateTime.now().add( const Duration(hours: 1)));

  Future<void> _getUserID() async {
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  void initState() {
    super.initState();
    _getUserID();
  }

  Future<void> uploadImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        pickedGalleryImage = pickedImage.path;
        file = File(pickedImage.path);
      });
    }

    imageUrl = await storeAndUploadDoctorImage(file!);
  }

  Future<String> storeAndUploadDoctorImage(File image) async {
    //instance storage . ref() 
    // name folder /
    //name file
    Reference ref = 
    FirebaseStorage.instanceFor(bucket: 'gs://se7ety-117-8ceaa.appspot.com')
        .ref()
        .child('doctors/$userID');
  // file  ---> link for image
  // type file
   SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
//file, image
   ref.putFile(file!,metadata);
   //file ---->link
   String url = await ref.getDownloadURL();
   return url;
  }
  showEndHourTimePicker() async{
    final pickedTime =  await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if( pickedTime != null){
      setState(() {
      endTime =  pickedTime.hour.toString();
      });
    }
  }

    showOpenHourTimePicker() async{
    final pickedTime =  await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if( pickedTime != null){
      setState(() {
      openTime =  pickedTime.hour.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            centerTitle: true,
            title: const Text('إكمال عملية التسجيل'),
          )),
      body: BlocListener<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is UpdateDoctorSuccessState) {
            // navigate to page
          } else if (state is UpdateDoctorErrorState) {
            pop(context);
            showErrorDialog(context, errorMessage: state.error);
          } else {
            showLoadingDialog(context);
          }
        },
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: (pickedGalleryImage != null)
                                ? FileImage(File(pickedGalleryImage!))
                                    as ImageProvider
                                : AssetImage(AssetsImages.user),
                            radius: 60,
                          ),
                          Positioned(
                            bottom: 0.25,
                            right: 0.5,
                            child: GestureDetector(
                              onTap: () async{
                              await  uploadImage();
                              },
                                child: const CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.white,
                              child: Icon(
                                Icons.camera_alt,
                                color: AppColors.primary,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'التخصص',
                      style:
                          getSmallStyle(color: AppColors.black, fontSize: 15),
               //       textDirection: TextDirection.rtl,
                    ),
                    const Gap(5),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.textFormFieldbg),
                      child: DropdownButton(
                        onChanged: (String? value) {
                          setState(() {
                            specialization = value ?? specializationList[0];
                          });
                        },
                        icon: const Icon(Icons.arrow_drop_down),
                        iconEnabledColor: AppColors.primary,
                        isExpanded: true,
                        value: specialization,
                        items: specializationList.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                      ),
                    ),

                    Text(
                      'نبذة تعريفية',
                      style:
                          getSmallStyle(color: AppColors.black, fontSize: 15),
               //       textDirection: TextDirection.rtl,
                    ),
                    ////////////////////////////////////
                    const Gap(5),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: bio,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      maxLines: 4,
                      decoration: InputDecoration(
                 //       hintTextDirection: TextDirection.rtl,
                        hintText:
                            'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي و خبراتك السابقة...',
                        hintStyle:
                            getSmallStyle(color: AppColors.grey, fontSize: 15),
                      ),
                    ),
                    const Gap(15),
                    const Divider(
                      color: AppColors.grey,
                    ),
                    const Gap(30),
                    Text(
                      'عنوان العيادة',
                      style:
                          getSmallStyle(color: AppColors.black, fontSize: 15),
                  //    textDirection: TextDirection.rtl,
                    ),
                    const Gap(5),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: address,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: '5 شارع مصدق - الدقي - الجيزة',
                     //   hintTextDirection: TextDirection.rtl,
                        hintStyle:
                            getSmallStyle(color: AppColors.grey, fontSize: 15),
                      ),
                    ),
                    Row(
                      // textDirection: TextDirection.rtl,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ساعات العمل من',
                                style: getSmallStyle(
                                    color: AppColors.black, fontSize: 15),
                              ),
                              const Gap(5),
                              TextField(
                                textInputAction: TextInputAction.next,
                                controller: openHour,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.access_time_rounded,
                                    color: AppColors.primary,
                                  ),
                                  hintText: openTime,
                     //             hintTextDirection: TextDirection.rtl,
                                  hintStyle: getSmallStyle(
                                      color: AppColors.grey, fontSize: 15),
                                ),readOnly: true,
                                onTap: () async {
                               await   showOpenHourTimePicker();
                                },
                              ),
                            ],
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الي',
                                style: getSmallStyle(
                                    color: AppColors.black, fontSize: 15),
                              ),
                              const Gap(5),
                              TextField(
                                textInputAction: TextInputAction.next,
                                controller: closeHour,
                               
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.access_time_rounded,
                                    color: AppColors.primary,
                                  ),
                                  hintText: endTime,
                       //           hintTextDirection: TextDirection.rtl,
                                  hintStyle: getSmallStyle(
                                      color: AppColors.grey, fontSize: 15),
                                ),readOnly: true,
                                onTap: () async{
                                  await  showEndHourTimePicker();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      'رقم الهاتف 1',
                      style:
                          getSmallStyle(color: AppColors.black, fontSize: 15),
                //      textDirection: TextDirection.rtl,
                    ),
                    const Gap(5),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: phone1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'هذا الحقل مطلوب';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: '+20xxxxxxxxxxx',
                   //     hintTextDirection: TextDirection.rtl,
                        hintStyle:
                            getSmallStyle(color: AppColors.grey, fontSize: 15),
                      ),
                    ),
                    Text(
                      'رقم الهاتف 2 (اختياري)',
                      style:
                          getSmallStyle(color: AppColors.black, fontSize: 15),
                //      textDirection: TextDirection.rtl,
                    ),
                    const Gap(5),
                    TextField(
                      textInputAction: TextInputAction.done,
                      controller: phone2,
                      decoration: InputDecoration(
                        hintText: '+20xxxxxxxxxxx',
                   //     hintTextDirection: TextDirection.rtl,
                        hintStyle:
                            getSmallStyle(color: AppColors.grey, fontSize: 15),
                      ),
                    ),
                    Center(
                        child: CustomElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                            context.read<AuthCubit>().updateDoctorProfile(
                              uid: FirebaseAuth.instance.currentUser!.uid,
                             address: address.text,
                              bio: bio.text,
                               closeHour: endTime,
                                openHour: openTime,
                                 phone1: phone1.text, 
                                 image: imageUrl ?? '', 
                                 specialization: specialization,
                                 phone2: phone2.text ?? '',
                                 );
                        }
                      },
                      text: 'التسجيل',
                      width: double.infinity,
                    )),
                  ],
                ),
              ),
            )),
      ),
      //bottomNavigationBar: ,
    );
  }
}
