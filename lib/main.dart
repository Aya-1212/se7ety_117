// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se7ety_117/core/services/app_local_storage.dart';
import 'package:se7ety_117/core/theme/app_theme.dart';
import 'package:se7ety_117/features/authorization/presentation/manager/auth_cubit.dart';
import 'package:se7ety_117/features/introduction/presentation/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLocalStorage.init();
  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDYn8kyokOM2hRUB6UNV9f9LE08zOKBiFY',
          appId: 'com.example.se7ety_117',
          messagingSenderId: '37287869174',
          projectId: 'se7ety-117-8ceaa'));
  //////////////////////////////////////////////////////
  
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: Apptheme.lightTheme,
        home: SplashView(),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },
      ),
    );
  }
}
