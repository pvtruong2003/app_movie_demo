import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/movie_detail/movie_detail_screen.dart';
import 'package:flutter/material.dart';

class ItemTop extends StatelessWidget {
  final Movie movie;

  const ItemTop({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => MovieDetailScreen(id: movie.id.toString(),)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45,
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
                   image: NetworkImage('http://image.tmdb.org/t/p/w500${movie.posterPath}')
                )
             ),
           ),
           SizedBox(height: 16,),
            Text(
              movie.title,
              style: TextStyle(
                  color: AppColor.black,
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
