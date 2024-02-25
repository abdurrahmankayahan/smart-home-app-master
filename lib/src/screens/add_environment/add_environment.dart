import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class addEnvironmentScreen extends StatelessWidget {
  static String routeName = '/addEnvironmentScreen';
  final List<String> environments = const [
    'Çocuk odası',
    'Oturma odası',
    'Çalışma odası',
    'Yemek odası',
    'Araba',
    'Bahçe',
    'Mutfak',
    'Banyo',
  ];

  const addEnvironmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title: const Padding(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text(
            'Ortam ekle',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 36,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 36,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context); // Geri dönme işlevi
            },
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 20, right: 15),
            child: Icon(
              Icons.add_task,
              size: 36,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 3,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                hintText: 'Bir ortam adı girin',
              ),
            ),
          ),
          const Divider(
            height: 10,
            thickness: 1,
            indent: 15,
            endIndent: 10,
            color: Color.fromARGB(255, 228, 224, 224),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Önerilen ortam"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: environments.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("heyyyyy");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      environments[index],
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
