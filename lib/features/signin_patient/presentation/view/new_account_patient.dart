import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/functions/text_form_feild.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/signin_patient/presentation/view/sign_in_patient.dart';

class NewAccountPatient extends StatefulWidget {
  const NewAccountPatient({super.key});

  @override
  State<NewAccountPatient> createState() => _NewAccountPatientState();
}

class _NewAccountPatientState extends State<NewAccountPatient> {
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
                '"سجل حساب جديد كـ"مريض',
                style: getTitleStyle(),
              ),
             const Gap(30),
              TextFormField(
                //style: const TextStyle(color:  AppColors.textFormFieldbg),
                decoration: InputDecoration(
                  hintTextDirection: TextDirection.rtl,
                    hintText: 'الاسم',
                    hintStyle: getSmallStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                    ),
                    suffixIcon: const Icon(
                      Icons.person,
                    )),
              ),
              appTextformFeild(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                onPressed: () {},
                child: Center(
                  child: Text(
                    'تسجيل حساب',
                    style: getBodyStyle(color: AppColors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        pushWithReplacement(context, const SignInPatientVeiw() );
                      },
                      child: Text(
                        'سجل دخول',    
                        style: getSmallStyle(
                            color: AppColors.primary, fontSize: 16),
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
