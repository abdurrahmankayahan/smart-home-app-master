// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/models/data_models/userModel.dart';
import 'package:flutter/widgets.dart';
import 'package:smart360/src/screens/add_environment/add_environment.dart';

class DarkContainer extends StatefulWidget {
  ///TODO: Dark Container yerine  bir  container uygulaması yaz  parametresi  propertyModel olsun.
  ///Pin bilgisine göre  sadece veri okur  (sensör) veya  1-0  çıktı verir. (role)
  ///(Pin bilgisine göre  containerda button   veya sadece text alanı tutulmalı)
  ///özellik ismi olmalı
  ///özelliği ifade eden resim için resim url bilgisi tutmalı
  ///value  bilgisi için  verileri almalı
  ///button olan container için on click fonk.  olmalı
  ///uzerine tıklandığında  özellikleri ayarlamak değişiklik yapmak için  sayfaları  açan fonk. olmalı (void callback  & Function)
  ///bu bilgileri içeren properyModel  yazılmalı
  ///!!Veritabanı bu bilgilere göre tekrar oluşturulmalıdır.

  final PropertyModel propertyModel;
  final String deviceSn;
  final VoidCallback onTap;
  final VoidCallback switchButton;
  final VoidCallback switchFav;
  final bool isFav;

  DarkContainer({
    Key? key,
    required this.propertyModel,
    required this.deviceSn,
    required this.onTap,
    required this.switchButton,
    required this.switchFav,
    required this.isFav,
  }) : super(key: key);

  @override
  State<DarkContainer> createState() => _DarkContainerState();
}

class _DarkContainerState extends State<DarkContainer> {
  String? email, deviceSn, userId;
  late UserModel user;

  @override
  void initState() {
    super.initState();
    fetchSvalue();
  }

  fetchSvalue() async {
    await HelperFunctions.initSP();
    UserModel userData = await HelperFunctions.getUserModel() as UserModel;

    print("-----------------------------------");
    print(userData.userId!);
    print(widget.deviceSn);
    print(widget.propertyModel.propertyName);
    print(widget.propertyModel.getPinVal);
    print("------------------------------------");

    DatabaseReference databaseRefVal = FirebaseDatabase.instance
        .ref()
        .child(userData.userId!)
        .child("devices")
        .child(widget.deviceSn)
        .child("components")
        .child(widget.propertyModel.propertyName!)
        .child("value");

    databaseRefVal.onValue.listen((event) {
      if (mounted) {
        setState(() {
          widget.propertyModel.setPinVal = event.snapshot.value.toString();
          print(' deger: ${widget.propertyModel.getPinVal}');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: getProportionateScreenWidth(140),
        height: getProportionateScreenHeight(140),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              // propertyModel.getPinIO == "0"
              //     ? Colors.green[100]
              //     :
              widget.propertyModel.getItsOn != null &&
                      widget.propertyModel.getPinVal == "1"
                  ? const Color.fromRGBO(0, 0, 0, 1)
                  : const Color(0xffededed),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(10),
            vertical: getProportionateScreenHeight(6),
          ),
          child: Column(
            crossAxisAlignment: widget.propertyModel.getItsOn != null
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: widget.propertyModel.getItsOn != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: widget.propertyModel.getItsOn != null &&
                              widget.propertyModel.getItsOn == true
                          ? const Color.fromRGBO(45, 45, 45, 1)
                          : const Color(0xffdadada),
                      borderRadius:
                          const BorderRadius.all(Radius.elliptical(45, 45)),
                    ),
                    child: SvgPicture.asset(
                      widget.propertyModel.propertyIcon == ""
                          ? "assets/icons/svg/info.svg"
                          : widget.propertyModel.propertyIcon!,
                      color: widget.propertyModel.getItsOn != null &&
                              widget.propertyModel.getPinVal == "1"
                          ? Colors.amber
                          : const Color(0xFF808080),
                    ),
                  ),
                  widget.propertyModel.getItsOn != null
                      ? InkWell(
                          onTap: widget.switchFav,
                          child: Icon(
                            Icons.star_rounded,
                            color: widget.isFav
                                ? Colors.amber
                                : const Color(0xFF808080),
                            // color: Color(0xFF808080),
                          ),
                        )
                      : Row()
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.propertyModel.getPropertyName.toString(),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: widget.propertyModel.getItsOn != null &&
                                  widget.propertyModel.getPinVal == "1"
                              ? Colors.white
                              : Colors.black,
                        ),
                  ),
                ],
              ),
              widget.propertyModel.getPinIO == "1"
                  ? widget.propertyModel.getItsOn != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.propertyModel.getItsOn == null
                                  ? 'Özellik'
                                  : (widget.propertyModel.getItsOn != null &&
                                          widget.propertyModel.getPinVal == "1"
                                      ? 'Açık'
                                      : 'Kapalı'),
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(
                                    color: widget.propertyModel.getItsOn !=
                                                null &&
                                            widget.propertyModel.getPinVal ==
                                                "1"
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                            ),
                            InkWell(
                              onTap: (() {
                                setState(() {
                                  widget.propertyModel.setPinVal =
                                      widget.propertyModel.getPinVal == "0"
                                          ? "1"
                                          : "0";
                                });
                                widget.propertyModel.getUpdateFunc(
                                    val: widget.propertyModel.getPinVal);
                              }),
                              //onTap: widget.propertyModel.getUpdateFunc,
                              // onTap:widget.switchButton,
                              child: Container(
                                width: 48,
                                height: 25.6,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: widget.propertyModel.getItsOn !=
                                              null &&
                                          widget.propertyModel.getPinVal == "1"
                                      ? Colors.black
                                      : const Color(0xffd6d6d6),
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
                                    width: widget.propertyModel.getItsOn !=
                                                null &&
                                            widget.propertyModel.getPinVal ==
                                                "1"
                                        ? 2
                                        : 0,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    widget.propertyModel.getItsOn != null &&
                                            widget.propertyModel.getPinVal ==
                                                "1"
                                        ? const Spacer()
                                        : const SizedBox(),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Row()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.propertyModel.getPinVal.toString(),
                          // "heynoluyor",
                          // sValue,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: widget.propertyModel.getItsOn != null &&
                                        widget.propertyModel.getPinVal == "1"
                                    ? Colors.white
                                    : Colors.black,
                              ),
                        )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
