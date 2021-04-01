import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/rating_bloc.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/rating.dart';
import 'package:app_movie/screens/reviews/item_rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddRatingScreen extends StatefulWidget {
  final String movieId;

  const AddRatingScreen({Key key, this.movieId}) : super(key: key);

  @override
  _AddRatingScreenState createState() => _AddRatingScreenState();
}

class _AddRatingScreenState extends State<AddRatingScreen> {
  RatingBloc ratingBloc;
  @override
  void initState() {
    if (ratingBloc == null) {
      ratingBloc = RatingBloc();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        hidePadding: true,
        appBar: AppBar(
          backgroundColor: AppColor.black,
          iconTheme: IconThemeData(
              //ToDo Repeat
              color: AppColor.white),
          elevation: 0,
          title: Text(
            'Your Review',
            style: TextStyle(
                color: AppColor.white,
                fontSize: AppFontSize.medium,
                fontWeight: AppFontWeight.medium),
          ),
        ),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'LOVED IT',
                      style: TextStyle(
                          color: AppColor.black.withOpacity(0.5),
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppFontSize.large),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    StreamBuilder<Rating>(
                      stream: ratingBloc.rating,
                      builder: (context, snapshot) {
                        Rating rating = snapshot.data;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                              ItemRating(
                                isRating: rating.ratingOne,
                                onPressed: () {
                                  ratingBloc.updateRating(
                                      isRatingOne: !rating.ratingOne,
                                      isRatingTwo: rating.ratingTwo,
                                      isRatingThree: rating.ratingThree,
                                      isRatingFour: rating.ratingFour,
                                      isRatingFive: rating.ratingFive);
                                },
                              ),
                              ItemRating(
                                isRating: rating.ratingTwo,
                                onPressed: rating.ratingOne ? ()  {
                                  ratingBloc.updateRating(
                                      isRatingOne: rating.ratingOne,
                                      isRatingTwo: !rating.ratingTwo,
                                      isRatingThree: rating.ratingThree,
                                      isRatingFour: rating.ratingFour,
                                      isRatingFive: rating.ratingFive);
                                }: null,
                              ),
                              ItemRating(
                                isRating: rating.ratingThree,
                                onPressed: rating.ratingTwo ?  () {
                                  ratingBloc.updateRating(
                                      isRatingOne: rating.ratingOne,
                                      isRatingTwo: rating.ratingTwo,
                                      isRatingThree: !rating.ratingThree,
                                      isRatingFour: rating.ratingFour,
                                      isRatingFive: rating.ratingFive);
                                }: null,
                              ),
                              ItemRating(
                                isRating: rating.ratingFour,
                                onPressed: rating.ratingThree ?  () {
                                  ratingBloc.updateRating(
                                      isRatingOne: rating.ratingOne,
                                      isRatingTwo: rating.ratingTwo,
                                      isRatingThree: rating.ratingThree,
                                      isRatingFour: !rating.ratingFour,
                                      isRatingFive: rating.ratingFive);
                                }: null,
                              ),
                              ItemRating(
                                isRating: rating.ratingFive,
                                onPressed: rating.ratingFour ?  () {
                                  ratingBloc.updateRating(
                                      isRatingOne: rating.ratingOne,
                                      isRatingTwo: rating.ratingTwo,
                                      isRatingThree: rating.ratingThree,
                                      isRatingFour: rating.ratingFour,
                                      isRatingFive: !rating.ratingFive);
                                }: null,
                              )
                            ],
                        );
                      }
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                      maxLines: 10,
                      maxLength: 100,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          hintText: 'Tell us what you like...'),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    MaterialButton(
                        color: AppColor.black,
                        splashColor: AppColor.black,
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          ratingBloc.addRating(movieId: widget.movieId);
                          ratingBloc.updateRating();
                        },
                        child: Text(
                          'Send',
                          style: TextStyle(color: AppColor.white),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void dispose() {
    ratingBloc.onDispose();
    super.dispose();
  }
}
