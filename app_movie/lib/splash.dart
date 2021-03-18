import 'package:app_movie/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoMain();
  }

  Future<void> gotoMain() async{
    Future<void>.delayed(const Duration(milliseconds: 3000)).then<void>((void value) => Navigator.pushReplacement(context,  MaterialPageRoute<void>(builder: (BuildContext ctx){
      return LoginScreen();
    })));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 32,
            child: const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ))),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.network(
              'https://pbs.twimg.com/profile_images/1243623122089041920/gVZIvphd_400x400.jpg',
              height: 400,
            )),
      ],
    );
  }
}
