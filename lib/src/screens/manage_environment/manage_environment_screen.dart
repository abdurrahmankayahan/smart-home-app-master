import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:smart360/helper/helper_function.dart';
import 'package:smart360/src/database/querry.dart';
import 'package:smart360/src/models/data_models/userModel.dart';

class ManageEnvScreen extends StatefulHookWidget {
  static String routeName = '/ManageEnvScreen';
  const ManageEnvScreen({super.key});

  @override
  State<ManageEnvScreen> createState() => _ManageEnvScreenState();
}
QuerryClass querry=QuerryClass();
class _ManageEnvScreenState extends State<ManageEnvScreen> {
  late final String username, userId;
  late DatabaseReference _databaseReference;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    _databaseReference = FirebaseDatabase.instance.ref();
    gettingUserData();
  }

  gettingUserData() async {
HelperFunctions hlp=HelperFunctions();
hlp.initSP;
UserModel user=await hlp.getUserModel() as UserModel;

    setState(() {
      username = user.userName!;
      userId = user.userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
   
  
    useEffect(() {
      if (userId.isEmpty) {
        return () {
          Center(child: CircularProgressIndicator());
        };
      }

      return () {
        print('HomeScreen disposed');
      };
    }, []);
   
   
   
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
        child: FutureBuilder(
          future: querry.getTabsName(userId),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
     return ListView(
children: snapshot.data!.map((e) => 
      ListTile( title: Text(e),)

     
     ).toList(),

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
