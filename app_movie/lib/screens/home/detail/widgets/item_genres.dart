import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:flutter/material.dart';

class ItemGenres extends StatelessWidget {
  final List<Genres> genres;

  const ItemGenres({Key key, this.genres}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: genres.map((e) {
        return Container(
          padding: const EdgeInsets.all(4.0),
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(4.0)),
          child: Text(
            e.name,
            style: const TextStyle(color: AppColor.white),
          ),
        );
      }).toList(),
    );
  }
}
