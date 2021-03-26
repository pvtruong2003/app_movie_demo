import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movies.dart';
import 'package:app_movie/screens/home/detail/home_movie_detail.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/material.dart';

class ItemTrending extends StatelessWidget {
  final Movies movie;

  const ItemTrending({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomeMovieDetail(id: movie.id.toString(),)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
        height: MediaQuery.of(context).size.height * 0.4,
        margin: EdgeInsets.only(right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(StringUtils.urlImage(movie.posterPath))
                  )
              ),
            ),
            SizedBox(height: 16,),
            Text(
              //Todo check null
              movie.title != null ? movie.title : 'No name',
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: AppFontSize.medium,
                  fontWeight: AppFontWeight.medium),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4,),
            Row(
              children: [
                Icon(Icons.star, size: 16, color: Colors.yellow,),
                Icon(Icons.star, size: 16, color: Colors.yellow,),
                Icon(Icons.star, size: 16, color: Colors.yellow,),
                Icon(Icons.star, size: 16, color: Colors.yellow,),
                Icon(Icons.star, size: 16, color: Colors.grey,),
              ],
            )
          ],),
      ),
    );
  }
}
