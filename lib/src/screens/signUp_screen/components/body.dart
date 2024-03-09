// import 'package:enelsis_app/helper/helper_function.dart';
// import 'package:enelsis_app/sabitler/ext.dart';
// import 'package:enelsis_app/sabitler/theme.dart';
// import 'package:enelsis_app/service/auth_service.dart';
// import 'package:enelsis_app/widgets/widgets.dart';

import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/service/auth_service.dart';
import 'package:smart360/src/database/querry.dart';
import 'package:smart360/src/models/data_models/userModel.dart';
import 'package:smart360/src/screens/home_screen/home_screen.dart';

import 'package:smart360/widgets/widgets.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart360/src/models/ext.dart';
import 'package:smart360/src/models/theme.dart';

class Body extends StatefulWidget {
  const Body({key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Tema tema = Tema();
  bool sifre_gozukme = false;
  bool _isLoading = false;

  late String user, email, password, name, department = "";
  final formkey = GlobalKey<FormState>();
  QuerryClass querry = QuerryClass();
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16), // ekran boyutunu ayarlamada cozebildim
        decoration: BoxDecoration(color: Colors.white),
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : SingleChildScrollView(
                child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text("Kayıt Ol",
                          style: GoogleFonts.bebasNeue(
                            color: Colors.blue,
                            fontSize: 30,
                          )),
                    ),
                    Container(
                      decoration: tema.inputBoxDec(),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "bilgileri eksiksiz doldurunuz";
                          } else {}
                          return null;
                        },
                        onSaved: (value) {
                          email = value!;
                        },
                        decoration: tema.inputDec(
                            "E-Posta Adresinizi Giriniz",
                            Icons
                                .people_alt_outlined), // burda tema.darttaki input giris alani yer aliyor
                        style: GoogleFonts.quicksand(
                          color: renk(metin_renk),
                        ),
                      ),
                    ),
                    Container(
                      decoration:
                          tema.inputBoxDec(), // temadan gelen box decaration
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 15),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "bilgileri eksiksiz doldurunuz";
                                } else {}
                                return null;
                              },
                              onSaved: (value) {
                                password = value!;
                              },
                              obscureText: sifre_gozukme,
                              decoration: tema.inputDec(
                                  "Şifrenizi Giriniz",
                                  Icons
                                      .lock_outline), // burda tema.darttaki input giris alani yer aliyor
                              style: GoogleFonts.quicksand(
                                color: renk(metin_renk),
                                letterSpacing: 3,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  sifre_gozukme = !sifre_gozukme;
                                });
                              },
                              icon: Icon(!sifre_gozukme
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.remove_red_eye),
                              color: renk(metin_renk)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: tema.inputBoxDec(),
                      margin: EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "bilgileri eksiksiz doldurunuz";
                          } else {}
                          return null;
                        },
                        onSaved: (value) {
                          name = value!;
                        },
                        decoration: tema.inputDec(
                            "Ad-Soyad Giriniz", Icons.person_add_alt),
                        style: GoogleFonts.quicksand(
                          color: renk(metin_renk),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [renk("224ABE"), renk("4E73DF")],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () async {
                          SignUP();
                          print(email);
                          print(password);
                        },
                        child: Center(
                          child: Text(
                            "Hesap Oluştur",
                            style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text.rich(TextSpan(
                        text: "Zaten bir hesabınız var mı? ",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Giriş Yap",
                              style: const TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(context, "/");
                                }),
                        ],
                      )),
                    ),
                  ],
                ),
              )),
      ),
    );
  }

  SignUP() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();
      setState(() {
        _isLoading = false;
      });
      await authService
          .registerUserWithEmailandPassword(name, email, password)
          .then(
        (value) async {
          if (value == true) {
            // saving the shared preference state

            HelperFunctions hlp = HelperFunctions();
            hlp.initSP();

            hlp.setUserInfo(
                UserModel(userName: name, userEmail: email, isLogged: true));

            // await HelperFunctions.saveUserLoggedInStatus(true);
            // await HelperFunctions.saveUserEmailSF(email);
            // await HelperFunctions.saveUserNameSF(name);

            Navigator.of(context).pushNamed(HomeScreen.routeName);
            formkey.currentState!.reset();
          } else {
            showSnackbar(context, Colors.red, value);
            setState(() {
              _isLoading = false;
            });
          }
        },
      );
    }
  }
}

// Kullanıcının Firestore'a verilerini kaydetme
void saveUserDataToFirestore(UserModel userModel) async {
  QuerryClass().newUser(userModel);
}
