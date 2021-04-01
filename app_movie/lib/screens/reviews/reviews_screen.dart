import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/rating_bloc.dart';
import 'package:app_movie/call_retry.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/screens/movie_detail/widgets/item_reviews.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final String movieId;

  const ReviewScreen({Key key, this.movieId}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  RatingBloc ratingBloc = RatingBloc();

  @override
  void initState() {
    ratingBloc.getReviews(id: widget.movieId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      contentBackgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.black,
          iconTheme: IconThemeData(
            //ToDo Repeat
            color: AppColor.white
          ),
          elevation: 0,
          title: Text('Reviews', style: TextStyle(color: AppColor.white, fontSize: AppFontSize.medium, fontWeight: AppFontWeight.medium),),
        ),
        child: StreamBuilder<List<Review>>(
          stream: ratingBloc.reviews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.first.error != null) {
                return CallRetry(
                  hideAppbar: false,
                  message: snapshot.data.first.error,
                  voidCallback: () {
                    ratingBloc.getReviews(id: widget.movieId);
                  }
                );
              }
              return ListView.separated(
                  itemBuilder:  (ctx, index) {
                    return  ItemReview(
                    review: snapshot.data[index],
                    );
                  },
                  separatorBuilder: (ctx, index) => Divider(),
                  itemCount: snapshot.data.length);
            }
            return Container();
          }
        ));
  }

  @override
  void dispose() {
    ratingBloc.onDispose();
    super.dispose();
  }

}
