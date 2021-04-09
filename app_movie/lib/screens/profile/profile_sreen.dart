import 'dart:io';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/constants.dart';
import 'package:app_movie/screens/profile/widgets/profile_menu.dart';
import 'package:app_movie/screens/profile/widgets/profile_pic.dart';
import 'package:app_movie/screens/profile_detail/profile_detail.dart';
import 'package:app_movie/service/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin<ProfileScreen>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.wb_sunny))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePic(onPressed: () => Navigator.pushNamed(context, ProfileDetailScreen.routerName),),
            SizedBox(height: 16),
            Text('Nicolas Adams', style: TextStyle(color: AppColor.black, fontSize: AppFontSize.large, fontWeight: AppFontWeight.semiBold),),
            SizedBox(height: 4),
            Text('phamvantruong@gmail.com', style: TextStyle(color: AppColor.grayA6, fontSize: AppFontSize.text, fontWeight: AppFontWeight.normal),),
            SizedBox(height: 8),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width*0.5,
              color: Colors.yellowAccent,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              onPressed: (){}, child: Text('Upgrade to Pro', style: TextStyle(color: AppColor.black.withOpacity(0.9), fontWeight: AppFontWeight.normal, fontSize: AppFontSize.label),),),
            SizedBox(height: 16),
            ProfileMenu(icon: Icons.emoji_people, text: "C",press: () {

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
              //ToDo logout
              StoreData.store(KeyStore.login, false);
              if (Platform.isAndroid) {
                SystemNavigator.pop(animated: true);
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
