import 'package:smart360/service/auth_service.dart';
import 'package:smart360/src/screens/login_screen/login_screen.dart';
import 'package:smart360/src/screens/menu_page/components/list_tile.dart';
import 'package:smart360/src/screens/stats_screen/stats_screen.dart';
import 'package:smart360/src/screens/savings_screen/savings_screen.dart';
import 'package:flutter/material.dart';
//import 'package:smart360/config/size_config.dart';

class MenuList extends StatefulWidget {
  MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //MenuListItem is custom tile in list_tile file
        MenuListItems(
          iconPath: 'assets/icons/menu_icons/stats.svg',
          itemName: 'İstatistik',
          function: () => Navigator.of(context).pushNamed(
            StatsScreen.routeName,
          ),
        ),
        MenuListItems(
          iconPath: 'assets/icons/menu_icons/devices.svg',
          itemName: 'Cihazlar',
          function: () {},
        ),
        MenuListItems(
          iconPath: 'assets/icons/menu_icons/savings.svg',
          itemName: 'Tasarruflar',
          function: () {
            Navigator.of(context).pushNamed(SavingsScreen.routeName);
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: MenuListItems(
            iconPath: 'assets/icons/menu_icons/settings.svg',
            itemName: 'Ayarlar',
            function: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: MenuListItems(
            iconPath: 'assets/icons/menu_icons/notifications.svg',
            itemName: 'Bildirimler',
            function: () {},
          ),
        ),
        ListTile(
          onTap: () async {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Çıkış yap"),
                    content:
                        const Text("Çıkış yapmak istediğinizden emin misiniz?"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await authService.signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (route) => false);
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                });
          },
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
          leading: const Icon(
            Icons.exit_to_app_rounded,
            size: 36,
          ),
          title: const Text(
            "Çıkış Yap",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
        )
      ],
    );
  }
}
