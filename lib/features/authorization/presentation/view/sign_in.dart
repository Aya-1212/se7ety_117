import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/email_validate.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/services/app_local_storage.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/features/doctor/doctor_app_view.dart';
import 'package:se7ety_117/features/patient/patient_app_view.dart';
import 'package:se7ety_117/core/widgets/custorm_dialogs.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_cubit.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_states.dart';
import 'package:se7ety_117/features/authorization/presentation/view/new_account.dart';

class SignInVeiw extends StatefulWidget {
  const SignInVeiw({super.key,});

  @override
  State<SignInVeiw> createState() => _SignInVeiwState();
}

class _SignInVeiwState extends State<SignInVeiw> {
  
  String handleUserType() {
    return AppLocalStorage.getData("isDoctor")? 'دكتور' : 'مريض';
  }
  @override
  void initState() {
    handleUserType();
    super.initState();
  }
  var password = TextEditingController();
  var email = TextEditingController();

  bool isVisible = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          if (AppLocalStorage.getData("isDoctor")) {
            //doctor //navigate to doctor app
              pushAndRemoveUntil(
              context,
              const DoctorAppView(),
            );
          } else {
            //patient
            pushAndRemoveUntil(context, const PatenitAppView());
          }
        } else if (state is LoginErrorState) {
          pop(context);
          showErrorDialog(context, errorMessage: state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.,
                children: [
                  Image.asset(
                    AssetsImages.sa7atyLogo,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                  Text(
                    'سجل دخول الان كـ"${handleUserType()}"',
                    style: getTitleStyle(),
                  ),
                  const Gap(30),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      } else if (!emailValidate(email: value)) {
                        return 'البريد الالكتروني غير صحيح';
                      }
                      return null;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        hintText: 'Aya4407@gmail.com',
                        hintStyle:
                            getSmallStyle(color: AppColors.grey, fontSize: 18),
                        prefixIcon: const Icon(
                          Icons.mail,
                        )),
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    controller: password,
                    textAlign: TextAlign.end,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon((isVisible)
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_rounded)),
                      hintText: '********',
                      hintStyle:
                          getSmallStyle(color: AppColors.grey, fontSize: 20),
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'نسيت كلمة السر؟',
                      style: getSmallStyle(color: AppColors.black),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().login(
                              userEmail: email.text,
                              userPassword: password.text);
                        
                      }
                      
                    },
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
                        style:
                            getSmallStyle(color: AppColors.black, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            // print(AppLocalStorage.getData("isDoctor"));
                            pushWithReplacement(
                                context,
                               const RegisterView());
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
        ),
      ),
    );
  }
}
