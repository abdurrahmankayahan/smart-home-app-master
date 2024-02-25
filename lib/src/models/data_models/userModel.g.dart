// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userName: json['userName']! as String,
      userEmail: json['userEmail']! as String,
      userId: json['userId']! as String,
      userPass: json['userPass']! as String,
      isLogged: json['isLogged']! as bool,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userId': instance.userId,
      'userPass': instance.userPass,
      'isLogged': instance.isLogged,
    };
