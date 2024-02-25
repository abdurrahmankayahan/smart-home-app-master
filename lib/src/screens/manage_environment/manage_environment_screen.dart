import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smart360/helper/helper_function.dart';

class ManageEnvScreen extends StatefulWidget {
  static String routeName = '/ManageEnvScreen';
  const ManageEnvScreen({super.key});

  @override
  State<ManageEnvScreen> createState() => _ManageEnvScreenState();
}

class _ManageEnvScreenState extends State<ManageEnvScreen> {
  late final String username, userId;
  late DatabaseReference _databaseReference;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    _databaseReference = FirebaseDatabase.instance.reference();
    gettingUserData();
  }

  gettingUserData() async {
    late String un, uid;
    await HelperFunctions.getUserNameFromSF().then((val) {
      un = val!;
    });
    await HelperFunctions.getUserIdSF().then((val) {
      uid = val!;
    });

    setState(() {
      username = un;
      userId = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title: const Padding(
          padding: EdgeInsets.only(top: 10, left: 15),
          child: Text(
            'Ortam yönetimi',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 26,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 26,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<DatabaseEvent>(
          stream: _databaseReference.child(userId).child("devices").onValue,
          builder:
              (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {
            if (snapshot.hasData) {
              List<String> deviceTitles = [];
              DataSnapshot dataSnapshot = snapshot.data!.snapshot;
              Map<dynamic, dynamic> values =
                  dataSnapshot.value as Map<dynamic, dynamic>;
              values.forEach((key, value) {
                Map<dynamic, dynamic> device = value as Map<dynamic, dynamic>;
                String title = device["config"]["title"];
                deviceTitles.add(title);
              });
              return ListView.builder(
                itemCount: deviceTitles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(deviceTitles[index]),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
