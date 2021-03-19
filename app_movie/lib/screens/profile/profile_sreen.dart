import 'package:app_movie/app_container.dart';
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
    return AppContainer(
      appBar: AppBar(),
      child: Container(),
    );
  }

  @override
  bool get wantKeepAlive => true;

}
