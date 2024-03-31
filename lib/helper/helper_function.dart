import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart360/src/models/data_models/userModel.dart';

class HelperFunctions {
  static String userInfo = "USERINFO";
  static late SharedPreferences sp;

  static Future<void> initSP() async {
    sp = await SharedPreferences.getInstance();
  }

  static Future<bool> setUserInfo(UserModel userModel) async {
    await initSP();
    return await sp.setString(userInfo, json.encode(userModel.toJson()));
  }

  static Future<String?> getUserInfo() async {
    return sp.getString(userInfo);
  }

  static Future<UserModel?> getUserModel() async {
    await initSP();
    String? jsonString = sp.getString(userInfo);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
      return UserModel.fromJson(jsonMap);
    } else {
      print("nulll deger donduuuuuuuuuuuuuuuuu");
      return null;
    }
  }

//   // saving the data to SF
// static Future<bool> initSF(bool isUserLoggedIn) async {
//      sp = await SharedPreferences.getInstance();
//     return await sp.setBool(userLoggedInKey, isUserLoggedIn);
//   }
//   static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
//      sp = await SharedPreferences.getInstance();
//     return await sp.setBool(userLoggedInKey, isUserLoggedIn);
//   }

//   static Future<bool> saveUserNameSF(String username) async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return await sf.setString(userNameKey, username);
//   }
//   static Future<bool> saveUserIdSF(String userId) async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return await sf.setString(userIdKey, userId);
//   }
//   static Future<bool> saveUserEmailSF(String userEmail) async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return await sf.setString(userEmailKey, userEmail);
//   }

//   // getting the data from SF

//   static Future<bool?> getUserLoggedInStatus() async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.getBool(userLoggedInKey);
//   }
//   static Future<String?> getUserIdSF() async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.getString(userIdKey);
//   }
//   static Future<String?> getUserEmailFromSF() async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.getString(userEmailKey);
//   }

//   static Future<String?> getUserNameFromSF() async {
//     SharedPreferences sf = await SharedPreferences.getInstance();
//     return sf.getString(userNameKey);
//   }
}



// SharedPreferences kütüphanesi kullanarak kullanıcı verilerini (giriş durumu, kullanıcı adı, e-posta, bölüm ve rol gibi) 
//cihazda depolamak ve geri almak için kullanılır. SharedPreferences, küçük miktarlarda yapılandırma veya kullanıcı verisi gibi
// basit verileri cihazda kalıcı olarak saklamak için kullanılır.

// Kullanıcının giriş durumunu (logged in veya logged out) depolamak ve geri almak için saveUserLoggedInStatus ve 
//getUserLoggedInStatus işlevlerini sağlar.
// Kullanıcı adını (userNameKey), e-posta adresini (userEmailKey), bölümü (userDepartmentKey) ve rolü (userRoolKey) depolamak ve
// geri almak için ilgili işlevleri sağlar. Bu işlevler, kullanıcının uygulama içindeki profil bilgilerini ve ayarlarını 
//depolamak için kullanılabilir.
//kullanıcı giriş yaptığında saveUserLoggedInStatus işlevi kullanılarak giriş durumu kaydedilir ve kullanıcı bilgileri 
//saklanabilir. Bu bilgilere ihtiyaç duyulduğunda da getUserLoggedInStatus ve diğer işlevler kullanılarak geri alınabilir.
// Bu şekilde, kullanıcı verileri uygulama oturumu boyunca veya cihaz yeniden başlatıldığında dahi korunmuş olur.
