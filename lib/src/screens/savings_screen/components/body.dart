import 'package:flutter/material.dart';
import 'package:smart360/config/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart360/src/screens/savings_screen/components/savings_widget.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title: const Padding(
          padding: EdgeInsets.only(top: 20, left: 15),
          child: Text(
            'Tasarruflar',
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
        // actions: const [
        //   IconButton(
        //     icon: SvgPicture.asset('assets/icons/svg/savings_filled.svg'),
        //     onPressed: () {
        //       // Yapılacak işlemler
        //     },
        //   ),
        // ],
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 20, right: 15),
            child: Icon(
              Icons.energy_savings_leaf_outlined,
              size: 36,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: getProportionateScreenWidth(10),
          right: getProportionateScreenWidth(10),
          bottom: getProportionateScreenHeight(15),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getProportionateScreenHeight(50),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7, right: 7),
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  const Savings(title: 'Haftalık tasarruf', savings: 200),
                  const Savings(title: 'Aylık tasarruf', savings: 800),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
