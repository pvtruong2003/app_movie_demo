import 'package:app_movie/app_container.dart';
import 'package:app_movie/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
         body: Stack(
           children: <Widget>[
             Positioned(
                 width: MediaQuery.of(context).size.width,
                 bottom: 12,
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
         ),
      ),
    );
    return AppContainer(
      child: Stack(
        children: <Widget>[
          Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 12,
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
      ),
    );
  }
}
