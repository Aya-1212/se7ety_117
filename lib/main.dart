// ignore_for_file: prefer_const_constructors_in_immutables, sort_child_properties_last, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:se7ety_117/core/theme/app_theme.dart';
import 'package:se7ety_117/core/services/app_local.dart';
import 'package:se7ety_117/features/welcome/presentation/view/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDYn8kyokOM2hRUB6UNV9f9LE08zOKBiFY',
          appId: 'com.example.se7ety_117',
          messagingSenderId: '37287869174',
          projectId: 'se7ety-117-8ceaa'));
  //////////////////////////////////////////////////////
  await Hive.initFlutter();
  await Hive.openBox('user');
  AppLocalStorage.init();
  //////////////////////////////////////////////////////
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      child: MaterialApp(
        themeMode: ThemeMode.light ,
        theme: Apptheme.lightTheme,
        home: WelcomeView(),
        debugShowCheckedModeBanner: false,
      ),
      textDirection: TextDirection.rtl,
    );
  }
}
