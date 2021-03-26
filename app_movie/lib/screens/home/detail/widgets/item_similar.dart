import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movie.dart';
import 'package:flutter/material.dart';

class ItemSimilar extends StatelessWidget {
  final Movie movie;

  const ItemSimilar({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              'http://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
              width: 140,
              height: 150,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            movie.title,
            style: TextStyle(
                color: AppColor.white,
                fontWeight: AppFontWeight.normal,
                fontSize: AppFontSize.medium),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
