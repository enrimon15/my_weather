import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_weather/pages/favorites/favorites_screen.dart';
import 'package:my_weather/pages/info/info_screen.dart';
import 'package:my_weather/pages/settings/settings_screen.dart';

class MainDrawer extends StatelessWidget {
  //list of menu items
  final List<DrawerItem> drawerItem = [
    DrawerItem(title: tr("drawer_home"), icon: Icons.location_on, onTap: '/'),
    if(!kIsWeb) DrawerItem(title: tr("drawer_favorites"), icon: Icons.star, onTap: FavoritesScreen.routeName),
    DrawerItem(title: tr("drawer_settings"), icon: Icons.settings, onTap: SettingsScreen.routeName),
    DrawerItem(title: 'DIVIDER'),
    DrawerItem(title: tr("drawer_info"), icon: Icons.info, onTap: InfoScreen.routeName),
  ];

  //builder method
  Widget buildDrawerListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style:  TextStyle(
            fontSize: 18,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/img/logo.png',
                  alignment: Alignment.bottomLeft,
                  height: 64,
                ),
                SizedBox(height: 5,),
                Text(
                  'My Weather',
                   style: GoogleFonts.quicksand(
                   color: Colors.white,
                   fontSize: 26,
                   fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20,),
          ...drawerItem.map((DrawerItem item) {
            if (item.title == 'DIVIDER')
              return Divider();
            else
              return buildDrawerListTile(
                  item.title,
                  item.icon,
                  () => Navigator.of(context).pushReplacementNamed(item.onTap),
              );
            //return buildDrawerListTile('Home', Icons.location_on),
          }).toList(),
        ],
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icon;
  final String onTap;

  DrawerItem({this.title, this.icon, this.onTap});
}
