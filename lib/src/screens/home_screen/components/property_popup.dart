import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/models/theme.dart';
import 'package:smart360/src/screens/home_screen/components/body.dart';

class PropertyPopup extends StatefulWidget {
  final String userId;
  final String deviceSn;
  final String propertyValue;
  final bool itsOn;
  final Function(String) onSave;

  const PropertyPopup({
    Key? key,
    required this.userId,
    required this.deviceSn,
    required this.propertyValue,
    required this.onSave,
    required this.itsOn,
  }) : super(key: key);

  @override
  _PropertyPopupState createState() => _PropertyPopupState();
}

class _PropertyPopupState extends State<PropertyPopup> {
  //String _selectedIcon = 'assets/images/blue.png';
  bool itsOn = false;
  late String propertyName;
  late String pinNo;
  late String pinVal;
  late String place = "";
  late List<String> uri;
  Tema tema = Tema();
  List<String> components = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    itsOn = widget.itsOn;
    fetchComponents();
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

  void fetchComponents() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('components').get();
    List<String> fetchedComponents = [];
    querySnapshot.docs.forEach((doc) {
      var cName = doc.get('cName');
      if (cName != null) {
        fetchedComponents.add(cName.toString());
      }
    });
    setState(() {
      components =
          fetchedComponents; // Alınan ülkeleri state içindeki listeye atıyoruz
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.amber[300],
      title: Text(
        "Özellik Ekle  (${widget.deviceSn})",
        textAlign: TextAlign.center,
        style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.55,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: tema.inputBoxDec(boxColor: Colors.white),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      } else {}
                      return null;
                    },
                    onSaved: (value) {
                      propertyName = value!;
                    },
                    decoration:
                        tema.inputDec("Özellik adı ", Icons.animation_sharp),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(boxColor: Colors.white),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      } else {}
                      return null;
                    },
                    onSaved: (value) {
                      pinNo = value!;
                    },
                    decoration: tema.inputDec(
                      "Pin Numarası",
                      Icons.animation_rounded,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Container(
                  decoration: tema.inputBoxDec(boxColor: Colors.white),
                  margin: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      } else {}
                      return null;
                    },
                    onSaved: (value) {
                      pinVal = value!;
                    },
                    decoration: tema.inputDec(
                      "Varsayılan Değer",
                      Icons.animation_rounded,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    DropdownButton<String>(
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      hint: Text('Components Seçiniz'),
                      value: null,
                      onChanged: (String? newValue) {
                        // DropdownButton'da değer seçildiğinde yapılacak işlem
                      },
                      items: components.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(country),
                        );
                      }).toList(),
                    ),
                  ],
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
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1),
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
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Kaydet',
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              print("${propertyName},${itsOn},${pinNo},${pinVal}");
              //widget.onSave(_newPropertyValue);
              querry.saveDeviceComp(
                  widget.userId,
                  widget.deviceSn,
                  PropertyModel(
                      propertyName: propertyName,
                      itsOn: itsOn ? "1" : "0",
                      pinNo: pinNo,
                      pinIO: pinNo));

              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
