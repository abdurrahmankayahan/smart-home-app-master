import 'package:firebase_database/firebase_database.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/screens/home_screen/components/property_popup.dart';
import 'package:smart360/src/screens/home_screen/components/savings_container.dart';
import 'package:smart360/src/screens/home_screen/components/weather_container.dart';
import 'package:smart360/src/screens/smart_ac/smart_ac.dart';
import 'package:smart360/src/screens/smart_fan/smart_fan.dart';
import 'package:smart360/src/screens/smart_light/smart_light.dart';
import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'add_device_widget.dart';
import 'dark_container.dart';

final databaseReference = FirebaseDatabase.instance.ref();

class Body extends StatelessWidget {
  final HomeScreenViewModel model;
  final String uid;
  final String sn;
  const Body(
      {Key? key, required this.model, required this.sn, required this.uid})
      : super(key: key);

  Future<Widget> db(BuildContext context) async {
    DataSnapshot s = await databaseReference.child(uid).get();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(7),
          vertical: getProportionateScreenHeight(7),
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF2F2F2),
        ),
        child: Column(
          children: [
            Text(sn),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              child: WeatherContainer(model: model),
            ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              child: SavingsContainer(model: model),
            ),
            Container(
              height: 200,
              child: GridView.count(
                crossAxisCount: 2,
                children: s
                    .child("devices")
                    .child(sn)
                    .child("components")
                    .children
                    .map(
                  (child) {
                    return (Padding(
                      padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                      child: DarkContainer(
                        itsOn: (child.child("value").value.toString() == "0"
                            ? false
                            : true),
                        switchButton: () {
                          child.ref.update({
                            'value':
                                child.child("value").value.toString() == "0"
                                    ? 1
                                    : 0
                          });
                          model.onRefresh();
                        },
                        onTap: () {
                          // Handle fan switch

                          // TODO: set setting page  for  your  property
                        },
                        iconAsset: 'assets/icons/svg/fan.svg',
                        device: child.key.toString(),
                        deviceCount: '2 cihaz',
                        switchFav: model.fanFav,
                        isFav: model.isFanFav,
                      ),
                    ));
                  },
                ).toList(),
              ),
            ),
            Row(children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenHeight(5)),
                  child: DarkContainer(
                    itsOn: null,
                    switchButton: () {},
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return PropertyPopup(
                            itsOn: false,
                            userId: uid,
                            deviceSn: sn,
                            propertyValue: 'Initial Value',
                            onSave: (newValue) {
                              // Handle property save
                            },
                          );
                        },
                      );

                      // TODO: set setting page  for  your  property
                    },
                    iconAsset: 'assets/icons/svg/info.svg',
                    device: "Yeni Özellik Ekle",
                    deviceCount: 'Özellik eklemek için dokun',
                    switchFav: () {},
                    isFav: model.isFanFav,
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: db(context),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.hasData) {
          return snapshot.data!;
        }
        return Center(child: Text('No data'));
      },
    );
  }
}
