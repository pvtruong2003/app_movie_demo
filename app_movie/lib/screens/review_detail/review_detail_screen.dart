import 'package:app_movie/app_bar.dart';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key key, this.review}) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
        appBar: customAppBar(
          title: review.author.toUpperCase()
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16,),
              Center(
                child: InkWell(
                  onTap: () {
                    _finishAccountCreation(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: _buildAvatar(),
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Row(
                children: const <Widget>[
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 16,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.grey,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: 8,),
              Text('Date reviewed: ${review.createdAt}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
              const SizedBox(height: 8,),
              Text(review.content)
            ],
          ),
        ));
  }

  Image _buildAvatar() {
    if (review.authorDetails.avatarPath.contains('https') ||
        review.authorDetails.avatarPath.contains('http')) {
      final String url = review.authorDetails.avatarPath.replaceFirst('/', '');
      return Image.network(
        url,
        height: 120,
        width: 120,
        fit: BoxFit.cover,
        scale: 1.0,
      );
    }
    return Image.network(
      'http://image.tmdb.org/t/p/w500/${review.authorDetails.avatarPath}',
      height: 120,
      width: 120,
      fit: BoxFit.cover,
      scale: 1.0,
    );
  }

  void _finishAccountCreation(BuildContext context) {
    Navigator.pushAndRemoveUntil<void>(
      context,
      MaterialPageRoute<void>(builder: (BuildContext context) => MainScreen()),
      ModalRoute.withName('/'),
    );
  }
}
