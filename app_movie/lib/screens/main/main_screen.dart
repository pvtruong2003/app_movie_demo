
import 'package:app_movie/app_container.dart';
import 'package:app_movie/screens/favorite/favorite_screen.dart';
import 'package:app_movie/screens/movie/movie_screen.dart';
import 'package:app_movie/screens/near_me/near_me_screen.dart';
import 'package:app_movie/screens/profile/profile_sreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String routerName = 'main';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  Widget currentScreen = MovieScreen();
  final List<Widget> pageList = <Widget>[];

  @override
  void initState() {
    pageList.add(MovieScreen());
    pageList.add(NearMeScreen());
    pageList.add(FavoriteScreen());
    pageList.add(ProfileScreen());
    super.initState();
  }
  final PageStorageBucket bucket = PageStorageBucket();


  @override
  Widget build(BuildContext context) {
    Widget child;
    switch(_index) {
      case 0 : child = MovieScreen(); break;
      case 1 : child = NearMeScreen(); break;
      case 2 : child = FavoriteScreen(); break;
      case 3 : child = ProfileScreen(); break;
    }
    return AppContainer(
      hidePadding: true,
      child: IndexedStack(
        index: _index,
        children: pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            _index = index;

          });
        },
        items: <BottomNavigationBarItem>[
          _bottomBarItem(icon: Icons.movie, label: 'Movie'),
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

