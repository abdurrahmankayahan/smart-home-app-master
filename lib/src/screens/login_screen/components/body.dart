import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/database/querry.dart';
import 'package:smart360/src/screens/splash_screen/splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart360/src/models/ext.dart';
import 'package:smart360/src/models/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  QuerryClass querry = QuerryClass();
  Tema tema = Tema();
  bool sifre_gozukme = false;

  final formkey = GlobalKey<FormState>();

  late String user, email, password, department = "";
  late String username;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/login.png',
                      height: getProportionateScreenHeight(300),
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                // const Padding(
                //   padding: EdgeInsets.all(20.0),
                //   child: Text(
                //     'Giriş yapıp hemen evinizi ve aracınızı\nyönetmeye başlayabilirsiniz',
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
                Container(
                  decoration: tema.inputBoxDec(),
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
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
                      Icons.people_alt_outlined,
                    ),
                    style: GoogleFonts.quicksand(
                      color: renk(metin_renk),
                    ),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(),
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          obscureText: sifre_gozukme,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "bilgileri eksiksiz doldurunuz";
                            } else {}
                            return null;
                          },
                          onSaved: (value) {
                            password = value!;
                          },
                          decoration: tema.inputDec(
                            "Şifrenizi Giriniz",
                            Icons.lock_outline,
                          ),
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
                        color: renk(metin_renk),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(2)),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            querry.signIn(context, email, password);
                          }
                        },
                        child: Center(
                          child: Text(
                            "Giriş Yap",
                            style: GoogleFonts.quicksand(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(2)),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Geri dön",
                            style: const TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, SplashScreen.routeName);
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
