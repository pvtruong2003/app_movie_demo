import 'package:app_movie/app_container.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/screens/booking/widgets/item_date.dart';
import 'package:app_movie/screens/booking/widgets/item_time.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key key, this.movie}) : super(key: key);

  final MovieDetail movie;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        child: ListView(
          children: [
           // Text('Lotte Cinema'),
            Text(movie.title, style: TextStyle(fontSize: AppFontSize.large, fontWeight: AppFontWeight.semiBold),),
            _buildRowTime(),
             Container(
               height: 80,
               child: ListView(
                 padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                 scrollDirection: Axis.horizontal,
                 children: [
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate(),
                   ItemDate()
                 ],
               ),
             ),
            Container(
              height: 40,
              margin: EdgeInsets.only(top: 24),
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                scrollDirection: Axis.horizontal,
                children: [
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                   ItemTime(),
                ],
              ),
            )
          ],
        ));
  }



  Row _buildRowTime() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              TextButton.icon(
                  style:  TextButton.styleFrom(
                    primary: AppColor.white,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0)
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.location_on_rounded, color: AppColor.black,),
                  label: Text('Lotte Cinema', style: TextStyle(color: Colors.cyan),)),
              TextButton.icon(
                  style:  TextButton.styleFrom(
                      primary: AppColor.white,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0)
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.timer, color: AppColor.black,),
                  label: Text('2h 45min', style: TextStyle(color: Colors.cyan),))
            ],
          );
  }
}
