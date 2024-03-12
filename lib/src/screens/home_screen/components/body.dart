import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/database/querry.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/screens/home_screen/components/property_popup.dart';
import 'package:smart360/src/screens/home_screen/components/savings_container.dart';
import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'dark_container.dart';

QuerryClass querry = QuerryClass();

class Body extends StatelessWidget {
  const Body(
      {Key? key, required this.model, required this.sn, required this.uid})
      : super(key: key);

  final HomeScreenViewModel model;
  final String sn;
  final String uid;

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

            Divider(),
            Container(
              height: 410,
              child: FutureBuilder(
                future: querry.getDeviceCompList(uid, sn),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PropertyModel>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.count(
                      crossAxisCount: 2,
                      children: snapshot.data!.map((e) {
                        return Padding(
                          padding:
                              EdgeInsets.all(getProportionateScreenHeight(5)),
                          child: DarkContainer(
                            propertyModel: e,
                            //itsOn: (e.pinVal == "0" ? false : true),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return PropertyPopup(
                                    propertyModel: e,
                                    userId: uid,
                                    deviceSn: sn,
                                    onSave: (newValue) {
                                      // Handle property save
                                    },
                                  );
                                },
                              );
                            },
                            iconAsset: "assets/icons/menu_icons/devices.svg",

                            switchButton: () {
                              e.getUpdateFunc();
                              model.onRefresh();
                            },
                            isFav: false,
                            switchFav: () {
                              print("sefsedds");
                            },
                            //iconAsset: 'assets/icons/svg/fan.svg',
                            //device: e.propertyName!,
                            //switchFav: model.fanFav,
                            //isFav: model.isFanFav,
                            //sensorValue: "dennnnn",
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Expanded(
                        child: Center(
                            child: CircularProgressIndicator(
                      color: Colors.amber,
                    )));
                  }
                },
              ),
            ),
            // Row(children: [
            //   Expanded(
            //     child: Pdding(
            //       padding: EdgeInsets.all(getProportionateScreenHeight(5)),
            //       child: DarkContaainer(
            //         itsOn: null,
            //         switchButton: () {},
            //         onTap: () {
            //           showDialog(
            //             context: context,
            //             builder: (context) {
            //               return PropertyPopup(
            //                 itsOn: false,
            //                 userId: uid,
            //                 deviceSn: sn,
            //                 propertyValue: 'Initial Value',
            //                 onSave: (newValue) {
            //                   // Handle property save
            //                 },
            //               );
            //             },
            //           );

            //           // TODO: set setting page  for  your  property
            //         },
            //         iconAsset: 'assets/icons/svg/info.svg',
            //         device: "Yeni Özellik Ekle",
            //         //deviceCount: 'Özellik eklemek için dokun',
            //         switchFav: () {},
            //         isFav: model.isFanFav,
            //         sensorValue: "deneme3",
            //       ),
            //     ),
            //   )
            // ]),
          ],
        ),
      ),
    );
  }

  //////
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: db(context),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
              color: Colors.amber,
            ))));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            return snapshot.data!;
          }
          return Center(child: Text('No data'));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PropertyPopup(
                propertyModel: PropertyModel(),
                userId: uid,
                deviceSn: sn,
                onSave: (newValue) {
                  // Handle property save
                },
              );
            },
          );
        },
        backgroundColor: Colors.amber,
        heroTag: 'AlertDialog',
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.black),
            // SizedBox(height: 2),
            // Text("Özellik ",
            //     style: TextStyle(fontSize: 12, color: Colors.black)),
            // SizedBox(height: 1),
            // Text("ekle", style: TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:smart360/config/size_config.dart';
// import 'package:smart360/service/weather_service.dart';
// import 'package:smart360/src/models/weather_model.dart';

// class WeatherContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<WeatherModel>>(
//       future: WeatherService().getWeatherData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('GUNCELLENIYOR');
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         } else if (snapshot.hasData) {
//           List<WeatherModel> _weathers = snapshot.data!;
//           return _buildWeatherContainer(_weathers);
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
  


  
// @override
// Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height:
//               getProportionateScreenHeight(120), // Increased container height
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: const Color(0xFFFFFFFF),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: getProportionateScreenWidth(10),
//               vertical: getProportionateScreenHeight(
//                   10), // Increased vertical padding
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 SizedBox(
//                   width: getProportionateScreenWidth(90),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Text(
//                       '${_weathers[0].durum.toUpperCase()}',
//                       style: TextStyle(fontSize: 14), // Adjusted text style
//                     ),
//                     Text(
//                       '${_weathers[0].derece.toLowerCase()}°C',
//                       style: TextStyle(fontSize: 14), // Adjusted text style
//                     ),
//                     SizedBox(
//                       height: getProportionateScreenHeight(5),
//                     ),
//                     Text(
//                       '${_weathers[0].gun.toUpperCase()}',
//                       style: TextStyle(fontSize: 14), // Adjusted text style
//                     ),
//                     Text(
//                       'Nem: ${_weathers[0].nem.toLowerCase()}',
//                       style: TextStyle(fontSize: 14), // Adjusted text style
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Image.network(
//           _weathers[0].ikon,
//           height: getProportionateScreenHeight(110),
//           width: getProportionateScreenWidth(140),
//           fit: BoxFit.contain,
//         ),
//       ],
//     );
//   }
// }


