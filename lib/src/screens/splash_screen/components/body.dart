import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/screens/login_screen/login_screen.dart';
import 'package:smart360/src/screens/signUp_screen/signUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Material(
            color: Colors.white,
            child: Image.asset('assets/images/login.png'),
          ),
          const Center(
            child: Text(
              'Akıllı Ev & Araba Sistemleri',
              style: TextStyle(fontSize: 30, color: Colors.green),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            'Yaşamınızı Akıllıca Şekillendirin!',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.blue,
                ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(70),
                  vertical: getProportionateScreenHeight(15),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // <-- Radius
                ),
                backgroundColor: Colors.blue[500]),
            child: Text(
              'Oturum Aç ',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(SignUpScreen.routeName);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(70),
                vertical: getProportionateScreenHeight(15),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // <-- Radius
              ),
            ),
            child: Text(
              'Hesap Oluştur ',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          )
        ],
      ),
    );
  }
}
