import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/movie_detail_bloc.dart';
import 'package:app_movie/call_retry.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/movie/widgets/item_movie.dart';
import 'package:app_movie/wigets/list_item_builder.dart';
import 'package:flutter/material.dart';

class SimilarMoviesScreen extends StatelessWidget {
  const SimilarMoviesScreen({Key key, this.movieDetailBloc}) : super(key: key);

  final MovieDetailBloc movieDetailBloc;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      hidePadding: true,
      appBar: AppBar(),
       child: StreamBuilder<List<Movie>>(
         stream: movieDetailBloc.similarMovies,
         builder: (BuildContext ctx, AsyncSnapshot<List<Movie>> snapshot) {
           if (snapshot.hasData) {
             if (snapshot.data[0].error != null) {
               return CallRetry(
                 message: snapshot.data[0].error,
                 showAppBar: false,
                 voidCallback: () async{
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
    );
  }
}
