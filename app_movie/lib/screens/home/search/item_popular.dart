import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/home/detail/home_movie_detail.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemPopular extends StatelessWidget {

  final Movie movie;

  const ItemPopular({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => HomeMovieDetail(
                id: movie.id.toString(),
              ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.33,
            margin: EdgeInsets.only(right: 12, top: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(StringUtils.urlImage(movie.posterPath))
                )
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24,),
                Text(movie.title, maxLines: 2, style: TextStyle(color: AppColor.white, fontWeight: AppFontWeight.normal, fontSize: AppFontSize.medium),),
                Text('Action: Adventure, Family', maxLines: 5, style: TextStyle(color: AppColor.white.withOpacity(0.7), fontWeight: AppFontWeight.normal, fontSize: AppFontSize.label),),
                Text('Director: Robert Stromberg', maxLines: 5, style: TextStyle(color: AppColor.white.withOpacity(0.7), fontWeight: AppFontWeight.normal, fontSize: AppFontSize.label),),
              ],
            ),
          )
        ],),
    );
  }
}
