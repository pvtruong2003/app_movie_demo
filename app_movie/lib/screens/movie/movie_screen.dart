import 'package:app_movie/app_bar.dart';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/movie_bloc.dart';
import 'package:app_movie/call_retry.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/movie/widgets/item_movie.dart';
import 'package:app_movie/screens/search/search_screen.dart';
import 'package:app_movie/wigets/list_item_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with AutomaticKeepAliveClientMixin<MovieScreen>{
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
    super.build(context);
    return AppContainer(
      hidePadding: true,
      appBar: customAppBar(title: 'Movie', centerTitle: true, actions: [
      IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push<void>(context, MaterialPageRoute<void>(builder: (BuildContext ctx) => SearchScreen()));
          })
      ]),
      child: RefreshIndicator(
        onRefresh: () async {
          _movieBloc.getMovies(page: _page);
        },
        child: StreamBuilder<List<Movie>>(
          stream: _movieBloc.movies,
          builder: (BuildContext ctx, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0].error != null) {
                return CallRetry(
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
  @override
  bool get wantKeepAlive => true;
}
