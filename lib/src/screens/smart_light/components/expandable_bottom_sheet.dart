import 'package:smart360/config/size_config.dart';
import 'package:smart360/src/screens/smart_light/components/date_container.dart';
import 'package:smart360/src/screens/smart_light/components/reusable_buttons.dart';
import 'package:smart360/src/screens/smart_light/components/time_container.dart';
import 'package:smart360/view/smart_light_view_model.dart';
import 'package:flutter/material.dart';

import 'advance_setting_container.dart';

class ExpandableBottomSheet extends StatelessWidget {
  const ExpandableBottomSheet({Key? key, required this.model})
      : super(key: key);

  final SmartLightViewModel model;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = const BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: radius),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 35,
                height: 4,
                decoration: const BoxDecoration(
                    color: Color(0xFF464646),
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tarife',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'odanın ışığını ayarla',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
                Switch.adaptive(
                  inactiveThumbColor: const Color(0xFFE4E4E4),
                  inactiveTrackColor: Colors.white,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xFF464646),
                  value: true,
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aralık 2023',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'İstenilen saati seçiniz',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.arrow_back_ios_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DateContainer(date: '01', day: 'P.tesi', active: true),
                  DateContainer(date: '02', day: 'Salı', active: false),
                  DateContainer(date: '03', day: 'Çarş', active: false),
                  DateContainer(date: '04', day: 'Perş', active: true),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'İstenilen zamanı seçiniz',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Açma Zamanı',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TimeContainer(
                        time: '10:27', meridiem: 'PM', active: true),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kapatma Zamanı',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const TimeContainer(
                        time: '7:30', meridiem: 'AM', active: false),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Gelişmiş ayarlar',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            const AdvanceSettings(),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ResuableButton(
                        active: false, buttonText: 'Temizle', onPress: () {}),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ResuableButton(
                        active: true, buttonText: 'Tarife', onPress: () {}),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
