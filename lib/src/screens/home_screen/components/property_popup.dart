import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/models/ext.dart';
import 'package:smart360/src/screens/home_screen/components/body.dart';

class PropertyPopup extends StatefulWidget {
  final String userId;
  final String deviceSn;
  final PropertyModel propertyModel;

  final Function(String) onSave;

  const PropertyPopup({
    Key? key,
    required this.userId,
    required this.deviceSn,
    required this.propertyModel,
    required this.onSave,
    
  }) : super(key: key);

  @override
  _PropertyPopupState createState() => _PropertyPopupState();
}

class _PropertyPopupState extends State<PropertyPopup> {
  final PropertyModel propertyModel=PropertyModel();
 String _selectedIcon = 'assets/images/blue.png';
  bool itsOn = false;

  late String place="";

  late List<String> uri;
  @override
  void initState() {
    super.initState();
    itsOn = widget.propertyModel.pinVal=="0"?false:true;
    //_newPropertyValue = widget.propertyValue;
  }

  Future<List<String>> _getlistIcons() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.png'))
        .toList();

    return imagePaths;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey,
      title: Text("Özellik Ekle("+widget.deviceSn+")"),
      content: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Özellik Adı",
              hintText: widget.propertyModel.propertyName,
            ),
            onChanged: (value) {
              setState(() {
                 propertyModel.propertyName=value ;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Pin Numarası",
              hintText: widget.propertyModel.getPinNo,
            ),
            onChanged: (value) {
              setState(() {
                propertyModel.pinNo = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Varsayılan Değer",
              hintText: widget.propertyModel.getPinVal,
            ),
            onChanged: (value) {
              setState(() {
                propertyModel.pinVal = value;
              });
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
              border: Border.all(
                color: const Color.fromRGBO(255, 255, 255, 1),
                width: 0,
              ),
            ),
            child: Column(
              children: [
                Text("İN-OUT Seçim"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(itsOn ? "Kontrol" : "Sensör"),
                      GestureDetector(
                        onTap: () => {
                          setState(() {
                            itsOn = !itsOn;
                          })
                        },
                        child: Container(
                          width: 48,
                          height: 25.6,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: itsOn
                                ? Color.fromARGB(255, 239, 184, 73)
                                : const Color(0xFF808080),
                            border: Border.all(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              width: 0,
                            ),
                          ),
                          child: Row(
                            children: [
                              itsOn ? const Spacer() : const SizedBox(),
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
                      ),
                    ])
              ],
            ),
          ),
          Divider(),
          Text("İcon seçin"),
          GestureDetector(
            onTap: () async {
              List<String> icons = await _getlistIcons();
              // ignore: use_build_context_synchronously
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Bir icon seç'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: icons.map((icon) {
                          return Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(width: 2)),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black12),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedIcon = icon;
                                      });
                                      // Navigator.pushReplacement(this.context,MaterialPageRoute(builder: build));
                                      Navigator.pop(context);
                                    },
                                    child: Image.asset(
                                      '$icon',
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ],
                              ));
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset('$_selectedIcon'),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('CANCEL'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text('SAVE'),
          onPressed: () {
            //widget.onSave(_newPropertyValue);
querry.saveDeviceComp(widget.userId,widget.deviceSn,
PropertyModel(
  propertyName: propertyModel.propertyName,
  pinVal: itsOn?"1":"0",
  pinNo: propertyModel.pinNo,
  pinIO: propertyModel.pinIO
  ));


            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
