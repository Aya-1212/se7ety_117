import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/functions/text_form_feild.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/signin_doctor/presentation/view/new_account_doctor.dart';

class SignInDoctorVeiw extends StatefulWidget {
  const SignInDoctorVeiw({super.key});

  @override
  State<SignInDoctorVeiw> createState() => _SignInDoctorVeiwState();
}

class _SignInDoctorVeiwState extends State<SignInDoctorVeiw> {
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
                '"سجل دخول الان كـ"دكتور',
                style: getTitleStyle(),
              ),
              const Gap(30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                appTextformFeild(),
             InkWell(
                onTap: (){},
                child: Text(
                    'نسيت كلمة السر؟',
                    style: getSmallStyle(color: AppColors.black),
                  ),
              ),],),
              const Gap(10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary),
                onPressed: () {},
                child: Center(
                  child: Text(
                    'تسجيل الدخول',
                    style: getBodyStyle(color: AppColors.white),
                  ),
                ),
              ),
              const Gap(10),
              Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ليس لدي حساب؟',
                    style: getSmallStyle(color: AppColors.black, fontSize: 16),
                  ),
                  TextButton(
                      onPressed: () {
                        pushWithReplacement(context, const NewAccountDoctor());
                      },
                      child: Text(
                        'سجل الان',
                        style: getSmallStyle(
                            color: AppColors.primary, fontSize: 16),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
