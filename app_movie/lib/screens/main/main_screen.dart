import 'file:///E:/Flutter/app_movie/app_movie/lib/screens/favorite/favorite_screen.dart';
import 'file:///E:/Flutter/app_movie/app_movie/lib/screens/movie/movie_screen.dart';
import 'file:///E:/Flutter/app_movie/app_movie/lib/screens/near_me/near_me_screen.dart';
import 'file:///E:/Flutter/app_movie/app_movie/lib/screens/profile/profile_sreen.dart';
import 'file:///E:/Flutter/app_movie/app_movie/lib/screens/trend/trend_screen.dart';
import 'package:app_movie/bloc/trending_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  static const String routerName = 'main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _index = 0;
  List<Widget> list = <Widget>[];

  @override
  void initState() {
    super.initState();
    list = <Widget>[
      MovieScreen(),
      TrendScreen(),
      NearMeScreen(),
      FavoriteScreen(),
      ProfileScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('------------------>');
    final ContentInherit  contentInherit = ContentInherit.of(context);
    return Scaffold(
      body: ContentInherit(
          index: _index,
          child: IndexedStack(
            index: _index,
            children: list,
          )),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _index = index;
            if (_index == 1) {
              trendingBloc.getTrending(page: 1);
            }
          });
        },
        items: <BottomNavigationBarItem>[
          _bottomBarItem(icon: Icons.movie, label: 'Movie'),
          _bottomBarItem(icon: Icons.trending_down_outlined, label: 'Trend'),
          _bottomBarItem(icon: Icons.near_me, label: 'Near me'),
          _bottomBarItem(icon: Icons.favorite, label: 'Favorite'),
          _bottomBarItem(icon: Icons.perm_contact_cal_rounded, label: 'My'),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
      ),
    );
  }

  BottomNavigationBarItem _bottomBarItem({IconData icon, String label}) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label);
  }
}

class ContentInherit extends InheritedWidget {
  const ContentInherit({this.index = 0, Widget child}) : super(child: child);
  final int index;

  @override
  bool updateShouldNotify(covariant ContentInherit oldWidget) {
    return oldWidget.index != index;
  }

  static ContentInherit of(BuildContext context) {
     return context.dependOnInheritedWidgetOfExactType<ContentInherit>();
  }
}
