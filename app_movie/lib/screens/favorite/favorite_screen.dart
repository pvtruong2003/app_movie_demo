import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with AutomaticKeepAliveClientMixin<FavoriteScreen>{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(),
    );  }

  @override
  bool get wantKeepAlive => true;
}
