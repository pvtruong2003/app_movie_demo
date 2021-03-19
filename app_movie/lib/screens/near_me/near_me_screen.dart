import 'package:app_movie/app_container.dart';
import 'package:flutter/material.dart';

class NearMeScreen extends StatefulWidget {
  @override
  _NearMeScreenState createState() => _NearMeScreenState();
}

class _NearMeScreenState extends State<NearMeScreen> with AutomaticKeepAliveClientMixin<NearMeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('---------------> NearMeScreen');
    return AppContainer(
      appBar: AppBar(),
      child: Container(),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
