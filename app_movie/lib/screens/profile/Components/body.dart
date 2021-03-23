import 'dart:io';

import 'package:app_movie/constants.dart';
import 'package:app_movie/service/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:app_movie/screens/profile/Components/profile_pic.dart';
import 'package:flutter/services.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(icon: Icons.emoji_people, text: "My account",press: () {

        },
        ),
        ProfileMenu(icon: Icons.notifications, text: "Notification",press: () {

        },
        ),
        ProfileMenu(icon: Icons.settings, text: "Setting",press: () {

        },
        ),
        ProfileMenu(icon: Icons.help, text: "Help Center",press: () {

        },
        ),
        ProfileMenu(icon: Icons.logout, text: "Log Out",press: () {
          StoreData.store(KeyStore.LOGIN, false);
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0);
          }
        },
        ),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key, 
    @required this.text, 
    @required this.icon, 
    @required this.press,
  }) : super(key: key);

final String text;
final IconData icon;
final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: () {
          press();
        },
        child: Row(
          children: [
            Icon(icon), 
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text, 
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
        ),
    );
  }
}

 