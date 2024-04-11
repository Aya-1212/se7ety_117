import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/functions/text_form_feild.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/signin_doctor/presentation/view/doctor_info.dart';
import 'package:se7ety_117/features/signin_doctor/presentation/view/signin_doctor.dart';
class NewAccountDoctor extends StatefulWidget {
  const NewAccountDoctor({super.key});

  @override
  State<NewAccountDoctor> createState() => _NewAccountDoctorState();
}

class _NewAccountDoctorState extends State<NewAccountDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AssetsImages.sa7atyLogo,fit: BoxFit.cover,height: 300,),
                const Gap(5),
                Text(
                  '"سجل حساب جديد كـ"دكتور',
                  style: getTitleStyle(),
              ),
                const Gap(30),
                TextFormField(
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                    hintText: 'الاسم',
                    hintStyle: getSmallStyle(
                      color: AppColors.grey,
                      fontSize: 15,
                    ),suffixIcon: const Icon(
                      Icons.person,
                    ))),
                appTextformFeild(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () {
                      pushWithReplacement(context, const DoctorRegister());
                    },
                    child: Center(
                      child: Text(
                         'تسجيل حساب',
                        style: getBodyStyle(color: AppColors.white),
                      ),
                    ),),
                const Gap(10)
,                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     TextButton(
                        onPressed: () {
                          pushWithReplacement(context, const SignInDoctorVeiw());
                        },
                        child: Text(
                          'سجل دخول' ,
                          style: getSmallStyle(color: AppColors.primary, fontSize: 16),
                        )),
                    Text(
                      'لدي حساب؟',
                      style: getSmallStyle(color: AppColors.black, fontSize: 16),
                    ),
                   
                  ],
                )
              ],
            ),
          ),
        ),
      
    );
  }
}