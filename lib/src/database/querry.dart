import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/models/data_models/userModel.dart';
import 'package:smart360/src/screens/home_screen/home_screen.dart';
import 'package:smart360/widgets/widgets.dart';

class QuerryClass {
  final firebaseAuth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref();
  QuerryClass() {}

  Future<QuerySnapshot> userIsAvailable(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  Future<UserCredential> userChec(String email, String password) {
    return firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  signIn(BuildContext context, String email, String password) async {
    final snap = await userIsAvailable(email);
    //TODO: Querrrysnpshot
    if (snap.docs.length > 0) {
      final doc = snap.docs[0];

      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      if (data != null &&
          data.containsKey('email') &&
          data.containsKey('name')) {
        String email = data['email'];
        String name = data['name'];
        String uuid = data["uid"];

        UserModel user = UserModel(
            userName: name, userEmail: email, userId: uuid, isLogged: true);

        HelperFunctions hlp = HelperFunctions();

        HelperFunctions.setUserInfo(user);

        print(uuid);
        print(name);
        print(email);
        try {
          final userResult = userChec(email, password);

          print(name);
          print(email);
          final pres = await SharedPreferences.getInstance();
          pres.setBool("onboarding", false);
          print("onb false");
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        } catch (e) {
          showSnackbar(context, Colors.red, e.toString());
          print(e.toString());
        }
      } else {
        showSnackbar(context, Colors.red, 'Kullanıcı bilgileri eksik');
      }
    } else {
      showSnackbar(context, Colors.red, 'Kullanıcı bulunamadı');
    }
  }

  newUser(UserModel userModel) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    await usersCollection.doc(userModel.userId).set({
      'email': userModel.userEmail,
      'password': userModel.userPass,
      'name': userModel.userName,
    });
  }

  Future<DataSnapshot> getDeviceComp(String uid, String sn) async {
    DataSnapshot tmp = await databaseReference.child(uid).get();
    return await tmp.child("devices").child(sn).child("components");
  }

  Future<List<PropertyModel>> getDeviceCompList(String uid, String sn) async {
    DataSnapshot tmp = await databaseReference.child(uid).get();
    return await tmp
        .child("devices")
        .child(sn)
        .child("components")
        .children
        .map((tmp) => PropertyModel(
              propertyName: tmp.key.toString(),
              componentId: tmp.child("componentId").value.toString(),
              propertyIcon: tmp.child("iconAsset").value.toString(),
              pinNo: tmp.child("pinNumber").value.toString(),
              pinIO: tmp.child("pinIOStatus").value.toString(),
              pinVal: tmp.child("value").value.toString(),
              updateFunc: (({val}) => {
                    tmp.ref.update({
                      'value': val ??
                          (tmp.child("value").value.toString() == "0" ? "1" : "0")
                    })
                  }),
            ))
        .toList();
  }

//TODO:  yeni  fonk   propertyModel update fonksiyonu içermeli bu fonksiyon querrydeki  satırı koşup ref. update yapmalı

  saveDeviceComp(String userId, String deviceSn, PropertyModel pm) {
    databaseReference
        .child(userId)
        .child("devices")
        .child(deviceSn)
        .child("components")
        .update({
      pm.propertyName!: {
        "componentId": pm.componentId!,
        "iconAsset": pm.propertyIcon!,
        "pinIOStatus": pm.pinIO!,
        "pinNumber": pm.pinNo!,
        "value": pm.pinVal!,
      }
    });
  }

  manageProfile(UserModel um) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    usersCollection.doc(um.userId).update({
      'email': um.userEmail,
      'name': um.userName,
    });
  }

  Future<DataSnapshot> fetchData(String userId) async {
    DataSnapshot snapshot = await databaseReference.child('$userId').get();

    if (snapshot.exists) {
      // Child varsa, verisini alın ve kullanın
      final pres = await SharedPreferences.getInstance();
      pres.setBool("onboarding", true);
      return snapshot;
      // Veri işleme kodunu buraya ekleyin
    } else {
      // Child yoksa, userId numarasını kaydedin
      // await databaseReference.child('$userId').child("devices").set({
      //   '34434232': {
      //     'components': {
      //       'isik': {'pinIOStatus': 1, 'pinNumber': 2, 'value': 0}
      //     },
      //     'config': {'place': "conf", 'title': "Akıllı Sistemler"}
      //   }
      // });
      // snapshot = await databaseReference.child('$userId').get();
      final pres = await SharedPreferences.getInstance();
      pres.setBool("onboarding", false);
    }

    return snapshot;
  }


  Future<List<Map<String,String>>>  fetchedComponentsData()async{

///  HATA:   sadece  name  geliyor... 
   QuerySnapshot querySnapshot =

        await FirebaseFirestore.instance.collection('components').get();
    return querySnapshot.docs
        .map((e) => {"id": e.id, "name": e.get("cName").toString()}
            as Map<String, String>)
        .toList();
  }

  Future<List<String>> getTabsBody(String userId) async {
    var data = await fetchData(userId);

    return data
        .child("devices")
        .children
        .map((tmp) => tmp.key.toString())
        .toList();
  }

  Future<List<String>> getTabsName(String userId) async {
    var data = await fetchData(userId);

    return data
        .child("devices")
        .children
        .map((tmp) => tmp.child("config").child("title").value.toString())
        .toList();
  }

  ///////////
  // String fetchSvalue(String userId, String deviceSn, String propertyName) {
  //   String sValue = "";
  //   print("-----------------------------------");
  //   print(userId);
  //   print(deviceSn);
  //   print(propertyName);
  //   print("------------------------------------");

  //   DatabaseReference databaseRefVal = FirebaseDatabase.instance
  //       .ref()
  //       .child(userId)
  //       .child("devices")
  //       .child(deviceSn)
  //       .child("components")
  //       .child(propertyName)
  //       .child("value");

  //   databaseRefVal.onValue.listen((event) {
  //     sValue = event.snapshot.value.toString();
  //   });
  //   return sValue;
  // }
  /////////////////
  // fetchSvalue(String userId, String deviceSn, String propertyName) {
  //   DatabaseReference databaseRefVal = FirebaseDatabase.instance
  //       .ref()
  //       .child(userId)
  //       .child("devices")
  //       //.child(deviceSn)
  //       .child("components")
  //       .child(propertyName)
  //       .child("value");

  //   return databaseRefVal;
  // }

  // Future<List<String>> fetchDeviceSn(String userId) async {
  //   List<String> deviceSnList = [];

  //   try {
  //     // Kullanıcının verilerini al
  //     DataSnapshot userDataSnapshot = (await FirebaseDatabase.instance
  //         .ref()
  //         .child(userId)
  //         .once()) as DataSnapshot;

  //     // devices düğümünün altındaki tüm çocukları döngü ile tarayın
  //     Map<dynamic, dynamic> userData =
  //         userDataSnapshot.value as Map<dynamic, dynamic>;
  //     Map<dynamic, dynamic> devicesData = userData['devices'];
  //     devicesData.forEach((key, value) {
  //       deviceSnList.add(key.toString()); // deviceSn değerini listeye ekleyin
  //     });

  //     return deviceSnList;
  //   } catch (e) {
  //     print('Hata: $e');
  //     return deviceSnList;
  //   }
  // }
}
