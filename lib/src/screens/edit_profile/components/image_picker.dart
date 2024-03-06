import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  FirebaseAuth auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  Future getImageFromCamera() async {
    var image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });

    // StorageReference referansYol = FirebaseStorage.instance.ref().child("profilresimleri").child(auth.currentUser!.uid).child("profilresimleri.png");
  }

  Future getImageFromGallery() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
          boxShadow: [
            BoxShadow(spreadRadius: 6, color: Colors.black38),
          ]),
      child: _image == null
          ? IconButton(
              icon: const Icon(
                Icons.upload_rounded,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                getImageFromGallery();
                // Save Image to some storage
              },
            )
          : InkWell(
              onTap: () {
                getImageFromGallery();
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
