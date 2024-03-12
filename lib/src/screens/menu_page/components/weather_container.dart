import 'package:flutter/material.dart';
import 'package:smart360/config/size_config.dart';
import 'package:smart360/service/weather_service.dart';
import 'package:smart360/src/models/weather_model.dart';

class WeatherContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WeatherModel>>(
      future:  WeatherService().getWeatherData(),
      builder: (BuildContext context, AsyncSnapshot<List<WeatherModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('GUNCELLENIYOR');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          List<WeatherModel> _weathers = snapshot.data!;
          return _buildWeatherContainer(_weathers);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildWeatherContainer(List<WeatherModel> _weathers) {
    if (_weathers.isEmpty) {
      return Container(); 
    }

    return Stack(
      children: [
        Container(
          height: getProportionateScreenHeight(120),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFFFFFFF),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(10),
              vertical: getProportionateScreenHeight(10),
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
                      '${_weathers[0].durum.toUpperCase()}',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '${_weathers[0].derece.toLowerCase()}°C',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(5),
                    ),
                    Text(
                      '${_weathers[0].gun.toUpperCase()}',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      'Nem: ${_weathers[0].nem.toLowerCase()}',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Image.network(
          _weathers[0].ikon,
          height: getProportionateScreenHeight(110),
          width: getProportionateScreenWidth(140),
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}