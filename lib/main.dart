import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart360/firebase_options.dart';
import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/provider/getit.dart';
import 'package:smart360/routes/routes.dart';
import 'package:smart360/src/models/data_models/userModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart360/src/screens/home_screen/home_screen.dart';
import 'package:smart360/view/onboarding/onboarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(MyApp(onboarding: onboarding));
}

class MyApp extends StatefulWidget {
  final bool onboarding;
  const MyApp({Key? key, required this.onboarding}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState(onboarding: onboarding);
}

class _MyAppState extends State<MyApp> {
  final bool onboarding;
  bool isLogged = false;

  _MyAppState({required this.onboarding});

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  late UserModel user;
  gettingUserData() async {
    HelperFunctions hlp = HelperFunctions();
    hlp.initSP();
    user = await hlp.getUserModel() as UserModel;

    setState(() {
      isLogged = user.getIsLogged!;
    });
  }

  final ThemeMode themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'smart360',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        fontFamily: 'Nato Sans',
        textSelectionTheme: const TextSelectionThemeData(
          // Set Up for TextFields
          cursorColor: Colors.grey,
          selectionColor: Colors.blueGrey,
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFF2F2F2),
          //secondary: Color(0xFFF4AE47),
          surface: Color(0xFFC4C4C4),
          background: Color(0xFFFFFFFF),
          error: Color(0xFFB00020),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Color(0xFF464646),
          ),
          displayMedium: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xFF464646),
          ),
          displaySmall: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Color(0xFF464646),
          ),
          headlineMedium: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Color(0xFFBDBDBD),
          ),
          headlineSmall: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xFFBDBDBD),
          ),
          titleLarge: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF464646),
          ),
        ),
      ),
      routes: routes,
      //home: isLogged==true?HomeScreen():SplashScreen(),
      home: onboarding ? HomeScreen() : OnboardingView(),
    );
  }
}
