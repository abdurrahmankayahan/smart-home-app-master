import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart360/src/models/data_models/propertyModel.dart';
import 'package:smart360/src/models/theme.dart';
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
  late TextEditingController propertyNameController;
  late TextEditingController pinNoController;
  late TextEditingController pinValController;

  late PropertyModel propertyModel;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, String>> components = [];
  Tema tema = Tema();
  late List<String> uri;
  late String propertyIcon;
  bool itsOn = false;
  String dropText = "Components Seçiniz";
  String? selectedComponentId;

  @override
  void initState() {
    super.initState();
    fetchComponents();

    // Initialize controllers with the values from the provided propertyModel
    propertyModel = widget.propertyModel;
    itsOn = propertyModel.pinVal == "0" ? false : true;
    dropText = propertyModel.componentId ?? "Components Seçiniz";
    selectedComponentId = propertyModel.componentId;
    propertyIcon = propertyModel.propertyIcon ?? "";

    propertyNameController =
        TextEditingController(text: propertyModel.propertyName);
    pinNoController = TextEditingController(text: propertyModel.pinNo);
    pinValController = TextEditingController(text: propertyModel.pinVal);
  }

  Future<List<String>> _getlistIcons() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final svgPaths = manifestMap.keys
        .where((String key) => key.contains('icons/device_icons/'))
        .where((String key) => key.contains('.svg'))
        .toList();

    return svgPaths;
  }

  void fetchComponents() async {
    List<Map<String, String>> tmp = await querry.fetchedComponentsData();

    setState(() {
      components = tmp;
      if (!components
          .any((component) => component['id'] == selectedComponentId)) {
        selectedComponentId = null;
        dropText = "Components Seçiniz";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      backgroundColor: Colors.amber,
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
                    controller: propertyNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      if (value! == widget.propertyModel.propertyName) {
                      } else {
                        print(
                            'uid: ${widget.userId} ozellikno: ${widget.deviceSn} propname: ${widget.propertyModel.propertyName!}');
                        // removeProperty çağrısı yapmadan önce propertyName'in boş olmadığını kontrol et
                        if (widget.propertyModel.propertyName != null &&
                            widget.propertyModel.propertyName!.isNotEmpty) {
                          querry.removeProperty(widget.userId, widget.deviceSn,
                              widget.propertyModel.propertyName!);
                        }
                        propertyModel.propertyName = value;
                      }
                    },
                    decoration: tema.inputDec("Özellik adı ", Icons.abc),
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
                    controller: pinNoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "bilgileri eksiksiz doldurunuz";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      propertyModel.pinNo = value!;
                    },
                    decoration: tema.inputDec(
                      "Pin Numarası",
                      Icons.cable,
                    ),
                    style: GoogleFonts.quicksand(color: Colors.black),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      menuMaxHeight: 150,
                      alignment: AlignmentDirectional.center,
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
                      hint: Row(children: [
                        const Icon(Icons.attractions),
                        Container(
                          width: MediaQuery.maybeOf(context)!.size.width * 0.4,
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            dropText,
                          ),
                        ),
                      ]),
                      value: selectedComponentId,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedComponentId = newValue;
                          dropText = components.firstWhere((component) =>
                              component['id'] == newValue)['name']!;
                          propertyModel.componentId = newValue;
                          if (dropText == "Buton") {
                            propertyModel.setPinIO = "1";
                          } else {
                            propertyModel.setPinIO = "0";
                          }
                        });

                        print(
                            '"dropttex: ${dropText} propertyModel.componentId: ${propertyModel.componentId}');
                        print("propertyModel.pinIO: ${propertyModel.pinIO}");
                      },
                      items: components.map((obj) {
                        return DropdownMenuItem<String>(
                          value: obj["id"],
                          child: Text(obj["name"].toString()),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const Divider(),
                const Text(
                  "İkon Seçiniz:",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    List<String> icons = await _getlistIcons();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            "İkon Seçiniz:",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 19),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: icons.map((icon) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            propertyIcon = icon;
                                            propertyModel.propertyIcon = icon;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: SvgPicture.asset(
                                          icon,
                                          width: 50,
                                          height: 50,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
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
                      child: propertyIcon == ""
                          ? SvgPicture.asset("assets/icons/svg/info.svg")
                          : SvgPicture.asset(propertyIcon)),
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

              print(
                  "denmeeeeee: ${widget.userId},${widget.deviceSn},${propertyModel.propertyName},${itsOn},${propertyModel.pinNo},${propertyModel.pinVal},${propertyModel.pinIO}");

              querry.saveDeviceComp(
                  widget.userId,
                  widget.deviceSn,
                  PropertyModel(
                      propertyName: propertyModel.propertyName,
                      componentId: propertyModel.componentId,
                      itsOn: itsOn ? "1" : "0",
                      pinNo: propertyModel.pinNo,
                      pinIO: propertyModel.pinIO, // pinIOStatus
                      pinVal: propertyModel.pinVal,
                      propertyIcon: propertyModel.propertyIcon));

              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
