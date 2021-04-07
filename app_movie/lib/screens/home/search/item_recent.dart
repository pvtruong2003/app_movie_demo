import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/home/detail/home_movie_detail.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemRecent extends StatelessWidget {

  final Movie movie;

  const ItemRecent({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => HomeMovieDetail(
                    id: movie.id.toString(),
                  ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.3,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                 image: NetworkImage(StringUtils.urlImage(movie.posterPath))
              )
            ),
          ),
        const SizedBox(height: 8,),
        Text(movie.title, maxLines: 2, style: TextStyle(color: AppColor.white, fontWeight: AppFontWeight.normal, fontSize: AppFontSize.medium),)
      ],),
    );
  }
}
