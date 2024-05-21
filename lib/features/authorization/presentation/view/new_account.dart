import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:se7ety_117/core/constants/assets_images.dart';
import 'package:se7ety_117/core/functions/email_validate.dart';
import 'package:se7ety_117/core/functions/routing.dart';
import 'package:se7ety_117/core/utils/app_colors.dart';
import 'package:se7ety_117/core/utils/text_style.dart';
import 'package:se7ety_117/core/widgets/app_view.dart';
import 'package:se7ety_117/core/widgets/custorm_dialogs.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_cubit.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_states.dart';
import 'package:se7ety_117/features/authorization/presentation/view/doctor_register.dart';
import 'package:se7ety_117/features/authorization/presentation/view/sign_in.dart';

class RegisterView extends StatefulWidget {
  final int index;
  const RegisterView({super.key, required this.index, });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  String handleUserType() {
    return widget.index==0? 'دكتور' : 'مريض';
  }

  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  bool isVisible = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if(widget.index==0){
            //doctor
           pushAndRemoveUntil(context, const DoctorRegister());
          }
          else{
            //patient
             pushAndRemoveUntil(context, const PatenitAppView());
          }
          
        } else if (state is RegisterErrorState) {
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
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsImages.sa7atyLogo,
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                  const Gap(5),
                  Text(
                    'سجل حساب جديد كـ"${handleUserType()}" ',
                    style: getTitleStyle(),
                  ),
                  const Gap(30),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: name,
                    //style: const TextStyle(color:  AppColors.textFormFieldbg),
                    decoration: InputDecoration(
                        // hintTextDirection: TextDirection.rtl,
                        hintText: 'الاسم',
                        hintStyle: getSmallStyle(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: email,
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        hintText: 'Aya4407@gmail.com',
                        hintStyle:
                            getSmallStyle(color: AppColors.grey, fontSize: 18),
                        prefixIcon: const Icon(
                          Icons.mail,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      } else if (!emailValidate(email: value)) {
                        return 'البريد الالكتروني غير صحيح';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
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
                      //Icon(
                      //  ,
                      //  ),
                      hintText: '********',
                      hintStyle:
                          getSmallStyle(color: AppColors.grey, fontSize: 20),
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'هذا الحقل مطلوب';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (widget.index == 0) {
                          //doctor
                          context.read<AuthCubit>().registerAsDoctor(
                              userEmail: email.text,
                              userPassword: password.text,
                              userName: name.text);
                        } else {
                          //patient
                          context.read<AuthCubit>().registerAsPatient(
                              userEmail: email.text,
                              userPassword: password.text,
                              userName: name.text);
                        }
                        //
                      }
                    },
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
                      Text(
                        'لدي حساب؟',
                        style:
                            getSmallStyle(color: AppColors.black, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            pushWithReplacement(
                                context,
                                SignInVeiw(
                                  index: widget.index,
                                ));
                          },
                          child: Text(
                            'سجل دخول',
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
