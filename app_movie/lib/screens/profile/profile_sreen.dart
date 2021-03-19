import 'package:app_movie/app_bar.dart';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/screens/profile/Components/body.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin<ProfileScreen>{
  @override
  Widget build(BuildContext context) {
    print('---------------> ProfileScreen');
    super.build(context);
    return Scaffold(
      // appBar: customAppBar(title: "Profile User", centerTitle: true),
      body: Body(),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
