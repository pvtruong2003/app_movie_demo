import 'package:app_movie/app_bar.dart';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/favorite_bloc.dart';
import 'package:app_movie/bloc/movie_bloc.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/favorite.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/booking/booking_screen.dart';
import 'package:app_movie/screens/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with AutomaticKeepAliveClientMixin<FavoriteScreen> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    favoriteBloc.getFavorite();
    _movieBloc = MovieBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    _movieBloc.navigatorScreen = navigatorScreen;
    return AppContainer(
      hidePadding: true,
      appBar: customAppBar(title: 'Your Favorites'),
      child: StreamBuilder<List<Favorite>>(
        stream: favoriteBloc.favorite,
        builder: (BuildContext context, AsyncSnapshot<List<Favorite>> snapshot) {
          if (snapshot.hasData) {
             return Container(
               height: MediaQuery.of(context).size.height,
               child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                        Favorite favorite = snapshot.data[index];
                    return buildRow(
                      movie: Movie(
                          id: favorite.movieId,
                          title: favorite.title,
                          posterPath: favorite.url,
                          overview: favorite.overview),
                    );
                  }),
             );
          }
          return Container();
        },
      ),
    );
  }

   buildRow({Movie movie}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => MovieDetailScreen(id: movie.id.toString(),)));
      },
      child: Container(
        height: 140,
        child: Row(
          children: [
            Container(
              height: 140,
              width: 100,
              margin: EdgeInsets.only(left: 16, right: 12, top: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'http://image.tmdb.org/t/p/w500${movie.posterPath}'))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24,),
                  Text(
                    movie.title,
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: AppFontSize.medium,
                        fontWeight: AppFontWeight.medium),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.yellow,),
                      Icon(Icons.star, size: 16, color: Colors.yellow,),
                      Icon(Icons.star, size: 16, color: Colors.yellow,),
                      Icon(Icons.star, size: 16, color: Colors.yellow,),
                      Icon(Icons.star, size: 16, color: Colors.grey,),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Text(
                    'Action, Adventure, Fantasy, Science Fiction',
                    style: TextStyle(
                        color: Colors.black26,
                        fontSize: AppFontSize.text,
                        fontWeight: AppFontWeight.normal),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Expanded(child: Container()),
                  GestureDetector(
                      onTap: () {
                        _movieBloc.getMovieDetail(id: movie.id.toString());
                      },
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.pink,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;

  void navigatorScreen(value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => BookingScreen(movie: value,)));
  }
}
