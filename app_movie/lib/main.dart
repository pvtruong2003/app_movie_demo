import 'package:app_movie/app_config.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/screens/login/login_screen.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:app_movie/screens/movie_detail/movie_detail_screen.dart';
import 'package:app_movie/screens/splash/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Use to get context from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
FirebaseAuth mAuth = FirebaseAuth.instance;


class RestartContainer extends StatelessWidget {
  Widget _getAppConfig(String en) {
    switch (en) {
      case 'dev':
        return AppConfig(
          child: createMyApp(),
          baseUrl: 'http',
          env: en,
        );
        break;
      case 'pro':
        return AppConfig(
          child: createMyApp(),
          baseUrl: 'http',
          env: en,
        );
        break;
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _getAppConfig('dev'),
    );
  }
}

Widget createMyApp() => MyApp();

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Use to all screen. AnnotatedRegion use for only screen
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //     statusBarColor: Colors.white,
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.light,
    //     systemNavigationBarColor: Colors.white, //Bottom bar
    //  //   systemNavigationBarDividerColor: Colors.white, // Bottom bar
    //     systemNavigationBarIconBrightness: Brightness.light));

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: AppFontFamily.prDisplay,
          primarySwatch: Colors.cyan,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Colors.transparent,
          dialogBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white
          ) ,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: AppColor.grayA6, fontSize: AppFontSize.text),
            contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]))
          )),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => SplashScreen(),
        LoginScreen.routerName: (BuildContext ctx) => LoginScreen(),
        MainScreen.routerName: (BuildContext ctx) => MainScreen(),
        MovieDetailScreen.routerName: (BuildContext ctx) =>
            const MovieDetailScreen(),
      },
      // onGenerateRoute: (RouteSettings setting) {
      //   if (setting.name == MovieDetailScreen.routerName) {
      //     final MovieDetailScreen arg = setting.arguments as MovieDetailScreen;
      //     return MaterialPageRoute<String>(
      //         builder: (BuildContext ctx) => MovieDetailScreen(id: arg.id));
      //   }
      //   assert(false, 'Need to implement ${setting.name}');
      //   return null;
      // },
    );
  }
}
