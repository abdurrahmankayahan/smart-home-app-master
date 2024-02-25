

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  String? userName="";
  String? userEmail="";
  String? userId="";
  String? userPass="";
  bool? isLogged=false;

  UserModel({
     this.userName="",
     this.userEmail="",
     this.userId="",
     this.userPass="",
     this.isLogged=false,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  get getJsonUserInfo => jsonEncode(toJson());

  
  



  String? get getUserName => userName;

  set setUserName(String userName) => this.userName = userName;

  String? get getUserEmail => userEmail;

  set setUserEmail(String userEmail) => this.userEmail = userEmail;

  String? get getUserId => userId;

  set setUserId(String userId) => this.userId = userId;

  String? get getUserPass => userPass;

  set setUserPass(String userPass) => this.userPass = userPass;

  bool? get getIsLogged => isLogged;

  set setIsLogged(bool isLogged) => this.isLogged = isLogged;
}