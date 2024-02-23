import 'package:smart360/src/screens/edit_profile/edit_profile.dart';
import 'package:smart360/src/screens/login_screen/login_screen.dart';
import 'package:smart360/src/screens/settings_screen/settings_screen.dart';
import 'package:smart360/src/screens/signUp_screen/signUp_screen.dart';
import 'package:smart360/src/screens/smart_ac/smart_ac.dart';
import 'package:smart360/src/screens/smart_light/smart_light.dart';
import 'package:smart360/src/screens/smart_fan/smart_fan.dart';
import 'package:smart360/src/screens/splash_screen/splash_screen.dart';
import 'package:smart360/src/screens/stats_screen/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart360/src/screens/home_screen/home_screen.dart';
import 'package:smart360/src/screens/savings_screen/savings_screen.dart';

// Routes arranged in ascending order

final Map<String, WidgetBuilder> routes = {
  EditProfile.routeName: (context) => const EditProfile(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SavingsScreen.routeName: (context) => const SavingsScreen(),
  SettingScreen.routeName: (context) => const SettingScreen(),
  SmartAC.routeName: (context) => const SmartAC(),
  SmartFan.routeName: (context) => const SmartFan(),
  SmartLight.routeName: (context) => const SmartLight(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  StatsScreen.routeName: (context) => const StatsScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen()
};
