import 'package:app_movie/bloc/login_bloc.dart';
import 'package:app_movie/debouncer.dart';
import 'package:app_movie/debug_screen.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/screens/login/login_screen.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake/shake.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  LoginBloc _loginBloc;
  Debouncer debouncer = Debouncer(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    ShakeDetector _ = ShakeDetector.autoStart(onPhoneShake: () {
      debouncer.run(() {
        _openDebug();
      });
    });
    _loginBloc = LoginBloc();
    Future.delayed(Duration(milliseconds: 2000)).then((value) => _loginBloc.getLogin());
  }

  _openDebug() async {
    var _= await navigatorKey.currentState.pushNamed(DebugScreen.routerName);
  }

  @override
  Widget build(BuildContext context) {
    _loginBloc.navigator = navigator;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark
      ),
      child: SafeArea(
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
    ),
    );
  }

  void navigator(dynamic isLogin) {
    if (isLogin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => MainScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => LoginScreen()));
    }
  }
}
