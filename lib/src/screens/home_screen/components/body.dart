import 'package:firebase_database/firebase_database.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/database/querry.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/screens/home_screen/components/property_popup.dart';
import 'package:smart360/src/screens/home_screen/components/savings_container.dart';
import 'package:smart360/src/screens/home_screen/components/weather_container.dart';

import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/material.dart';

import 'dark_container.dart';


QuerryClass querry=QuerryClass();
class Body extends StatelessWidget {
  final HomeScreenViewModel model;
  final String uid;
  final String sn;
  const Body(
      {Key? key, required this.model, required this.sn, required this.uid})
      : super(key: key);

  Future<Widget> db(BuildContext context) async {

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
            // Padding(
            //   padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            //   child: WeatherContainer(model: model),
            // ),
            Padding(
              padding: EdgeInsets.all(getProportionateScreenHeight(5)),
              child: SavingsContainer(model: model),
            ),
            
            Container(
              height: 200,
               child: FutureBuilder(
    future: querry.getDeviceComp(uid, sn),
    builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
      if (snapshot.hasData) {
        return GridView.count(
          crossAxisCount: 2,
          children: snapshot.data!.children.map((e) 
          {return Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            child: DarkContainer(
              itsOn: (e.child("value").value.toString() == "0"
                  ? false
                  : true),
              switchButton: () {
                e.ref.update({
                  'value':
                      e.child("value").value.toString() == "0"
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
              device: e.key.toString(),
              deviceCount: '2 cihaz',
              switchFav: model.fanFav,
              isFav: model.isFanFav,
            ),
      );}).toList(),
        );
      } else {
        return CircularProgressIndicator();
      }
    },
  ),
                        
              
            ),
           
           Divider(),
  Container(
              height: 200,
               child: FutureBuilder(
    future: querry.getDeviceCompList(uid, sn),
    builder: (BuildContext context, AsyncSnapshot<List<PropertyModel>> snapshot) {
      if (snapshot.hasData) {
        return GridView.count(
          crossAxisCount: 2,
          children: snapshot.data!.map((e) 
          {return Padding(
            padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            child: DarkContainer(
              itsOn: (e.pinVal == "0"
                  ? false
                  : true),
              switchButton: () {
                e.getUpdateFunc();
                model.onRefresh();
              },
              onTap: () {
                // Handle fan switch

                // TODO: set setting page  for  your  property
              },
              iconAsset: 'assets/icons/svg/fan.svg',
              device: e.propertyName!,
              deviceCount: '2 cihaz',
              switchFav: model.fanFav,
              isFav: model.isFanFav,
            ),
      );}).toList(),
        );
      } else {
        return CircularProgressIndicator();
      }
    },
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
