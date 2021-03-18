import 'package:app_movie/locator.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:app_movie/screens/movie_detail/movie_detail_screen.dart';
import 'package:app_movie/splash.dart';
import 'package:flutter/material.dart';
final GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();

void main() {
  setLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
          border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
          errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[400])),
        )
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => SplashScreen(),
        MainScreen.routerName: (BuildContext ctx) => MainScreen(),
        MovieDetailScreen.routerName: (BuildContext ctx) =>  const MovieDetailScreen(),
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
