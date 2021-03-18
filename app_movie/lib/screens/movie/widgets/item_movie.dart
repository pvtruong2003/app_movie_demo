import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class ItemMovie extends StatelessWidget {
  const ItemMovie({Key key, this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
         Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext ctx) => MovieDetailScreen(id: movie.id.toString(),)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          children: <Widget>[
            Container(
                height: 105,
                width: 110,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'http://image.tmdb.org/t/p/w500${movie.posterPath}')))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 12, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      movie.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
