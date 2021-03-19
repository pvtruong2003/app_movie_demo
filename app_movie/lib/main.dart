import 'package:app_movie/app_config.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:app_movie/screens/movie_detail/movie_detail_screen.dart';
import 'package:app_movie/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

//Use to get context from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
          primarySwatch: Colors.cyan,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400])),
          )),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => SplashScreen(),
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
