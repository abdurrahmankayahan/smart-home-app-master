import 'dart:math';

import 'package:smart360/provider/base_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenViewModel extends BaseModel {
  //-------------VARIABLES-------------//
  int selectedIndex = 0;
  int randomNumber = 1;
  final PageController pageController = PageController();
  bool isLightOn = true;
  bool isACON = false;
  bool isSpeakerON = false;
  bool isFanON = false;
  bool isLightFav = false;
  bool isACFav = false;
  bool isSpeakerFav = false;
  bool isFanFav = false;
  final databaseReference = FirebaseDatabase.instance.ref();

  void generateRandomNumber() {
    randomNumber = Random().nextInt(8);
    notifyListeners();
  }

  void lightFav() {
    isLightFav = !isLightFav;
    notifyListeners();
  }

  void acFav() {
    isACFav = !isACFav;
    notifyListeners();
  }

  void speakerFav() {
    isSpeakerFav = !isSpeakerFav;
    notifyListeners();
  }

  void fanFav() {
    isFanFav = !isFanFav;
    notifyListeners();
  }

  void acSwitch() {
    isACON = !isACON;
    databaseReference
        .child("2326468")
        .child("Priz")
        .update({'value': isACON ? 0 : 1});
    print('{$isACON} oldu');
    notifyListeners();
  }

  void speakerSwitch() {
    isSpeakerON = !isSpeakerON;
    notifyListeners();
  }

  void fanSwitch() {
    isFanON = !isFanON;
    notifyListeners();
  }

  void lightSwitch() {
    isLightOn = !isLightOn;

    databaseReference
        .child("2326468")
        .child("Isik")
        .update({'value': isLightOn ? 1 : 0});
    print('{$isLightOn} oldu');
    notifyListeners();
  }

  ///On tapping bottom nav bar items
  void onItemTapped(int index) {
    selectedIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    notifyListeners();
  }

  void onRefresh(){
    notifyListeners();
  }
}
