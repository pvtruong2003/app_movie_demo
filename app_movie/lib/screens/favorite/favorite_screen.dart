import 'package:app_movie/app_bar.dart';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/favorite_bloc.dart';
import 'package:app_movie/model/favorite.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/movie/widgets/item_movie.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with AutomaticKeepAliveClientMixin<FavoriteScreen>{
  @override
  void initState() {
    favoriteBloc.getFavorite();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppContainer(
      hidePadding: true,
      appBar: customAppBar(title: 'Your Favorites'),
      child: StreamBuilder<List<Favorite>>(
        stream: favoriteBloc.favorite,
        builder: (BuildContext context, AsyncSnapshot<List<Favorite>> snapshot) {
          if (snapshot.hasData) {
             return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                      Favorite favorite = snapshot.data[index];
                  return ItemMovie(
                    movie: Movie(
                        id: favorite.movieId,
                        title: favorite.title,
                        posterPath: favorite.url,
                        overview: favorite.overview),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
