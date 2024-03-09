import 'package:smart360/config/size_config.dart';
import 'package:smart360/view/home_screen_view_model.dart';
import 'package:flutter/material.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height:
              getProportionateScreenHeight(120), // Increased container height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFFFFFFF),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(
                  10), // Increased vertical padding
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(90),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '15°C',
                      style: TextStyle(fontSize: 24), // Adjusted text style
                    ),
                    Text(
                      'Yağmurlu',
                      style: TextStyle(fontSize: 18), // Adjusted text style
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    Text(
                      '28 Aralık 2023',
                      style: TextStyle(fontSize: 14), // Adjusted text style
                    ),
                    Text(
                      'Turkiye, Trabzon',
                      style: TextStyle(fontSize: 14), // Adjusted text style
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Image.asset(
          'assets/images/weather/0.png',
          height: getProportionateScreenHeight(110),
          width: getProportionateScreenWidth(140),
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
