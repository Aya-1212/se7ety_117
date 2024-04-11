import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';

class DoctorRegister extends StatefulWidget {
  const DoctorRegister({super.key});

  @override
  State<DoctorRegister> createState() => _DoctorRegisterState();
}

class _DoctorRegisterState extends State<DoctorRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            centerTitle: true,
            title: const Text('إكمال عملية التسجيل'),
          )),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              const Gap(20),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(AssetsImages.user),
                      radius: 60,
                    ),
                    Positioned(
                      bottom: 0.25,
                      right: 0.5,
                      child: GestureDetector(
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
                style: getSmallStyle(color: AppColors.black, fontSize: 15),
                textDirection: TextDirection.rtl,
              ),
              const Gap(5),
              TextFormField(
                decoration: InputDecoration(
                    hintTextDirection: TextDirection.rtl,
                    hintText: 'دكتور عظام',
                    hintStyle:
                        getSmallStyle(color: AppColors.black, fontSize: 15),
                    prefixIcon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: AppColors.primary,
                    )),
              ),
              Text(
                'نبذة تعريفية',
                style: getSmallStyle(color: AppColors.black, fontSize: 15),
                textDirection: TextDirection.rtl,
              ),
              const Gap(5),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                  hintText:
                      'سجل المعلومات الطبية العامة مثل تعليمك الأكاديمي و خبراتك السابقة...',
                  hintStyle: getSmallStyle(color: AppColors.grey, fontSize: 15),
                ),
              ),
              const Gap(15),
              const Divider(
                color: AppColors.grey,
              ),
              const Gap(30),
              Text(
                'عنوان العيادة',
                style: getSmallStyle(color: AppColors.black, fontSize: 15),
                textDirection: TextDirection.rtl,
              ),
              const Gap(5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '5 شارع مصدق - الدقي - الجيزة',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: getSmallStyle(color: AppColors.grey, fontSize: 15),
                ),
              ),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'ساعات العمل من',
                          style: getSmallStyle(
                              color: AppColors.black, fontSize: 15),
                        ),
                        const Gap(5),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.access_time_rounded,
                              color: AppColors.primary,
                            ),
                            hintText: 'AM 10:00',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: getSmallStyle(
                                color: AppColors.grey, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الي',
                          style: getSmallStyle(
                              color: AppColors.black, fontSize: 15),
                        ),
                        const Gap(5),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.access_time_rounded,
                              color: AppColors.primary,
                            ),
                            hintText: 'PM 10:00',
                            hintTextDirection: TextDirection.rtl,
                            hintStyle: getSmallStyle(
                                color: AppColors.grey, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                'رقم الهاتف 1',
                style: getSmallStyle(color: AppColors.black, fontSize: 15),
                textDirection: TextDirection.rtl,
              ),
              const Gap(5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '+20xxxxxxxxxxx',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: getSmallStyle(color: AppColors.grey, fontSize: 15),
                ),
              ),
              Text(
                'رقم الهاتف 2 (اختياري)',
                style: getSmallStyle(color: AppColors.black, fontSize: 15),
                textDirection: TextDirection.rtl,
              ),
              const Gap(5),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '+20xxxxxxxxxxx',
                  hintTextDirection: TextDirection.rtl,
                  hintStyle: getSmallStyle(color: AppColors.grey, fontSize: 15),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fixedSize: const Size.fromHeight(55)),
                onPressed: () {},
                child: Text(
                  'التسجيل',
                  style: getBodyStyle(color: AppColors.white),
                ),
              )
            ],
          )),
    );
  }
}
