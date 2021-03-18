import 'package:app_movie/bloc/movie_detail_bloc.dart';
import 'package:app_movie/screens/movies/similar_screen.dart';
import 'package:flutter/material.dart';

class ItemAll extends StatelessWidget {
  const ItemAll({Key key, this.movieDetailBloc}) : super(key: key);

  final MovieDetailBloc movieDetailBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width: 110,
        margin: const EdgeInsets.only(right: 12.0),
        child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute<void>(builder: (BuildContext ctx) {
              return SimilarMoviesScreen(movieDetailBloc: movieDetailBloc,);
            }));
          },
          child: const Icon(
            Icons.add,
            size: 44,
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(8.0))));
  }
}
