import 'package:app_movie/bloc/movie_bloc.dart';
import 'package:app_movie/display_connect_internet.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/movie/widgets/item_movie.dart';
import 'package:app_movie/screens/search/search_screen.dart';
import 'package:app_movie/wigets/list_item_builder.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieBloc _movieBloc;
  final int _page = 1;

  @override
  void initState() {
    _movieBloc = MovieBloc();
    _movieBloc.getMovies(page: _page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('------------> MovieScreen');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                 Navigator.push<void>(context, MaterialPageRoute<void>(builder: (BuildContext ctx) => SearchScreen()));
              })
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _movieBloc.getMovies(page: _page);
        },
        child: StreamBuilder<List<Movie>>(
          stream: _movieBloc.movies,
          builder: (BuildContext ctx, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0].error != null) {
                return DisplayConnectInternet(
                  message: snapshot.data[0].error,
                  showAppBar: false,
                  voidCallback: () async{
                    _movieBloc.getMovies(page: _page);
                  },
                );
              }
              return ListItemBuilder<Movie>(
                items: snapshot.data,
                itemBuilder: (BuildContext ctx, Movie movie) {
                  return ItemMovie(
                    movie: movie,
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
