import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/screens/review_detail/review_detail_screen.dart';
import 'package:flutter/material.dart';

class ItemReview extends StatelessWidget {
  const ItemReview({Key key, this.review}) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(56),
                  child: review.authorDetails.avatarPath != null
                      ? _buildAvatar()
                      : _buildAvatarDefault(),
                ),
                Positioned(left: 56, top: 8, child: Text(review.author, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),)),
                Positioned(
                    left: 56,
                    top: 24,
                    child: Row(
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
                    )),
                Positioned(top: 8, right: 0, child: Text(review.createdAt)),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          Text(
            review.content,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 4,
          ),
           Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext ctx) => ReviewScreen(review: review,)));
                  },
                  child: const Text('See more'))),
          Row(
            children: <Widget>[
               Image.network('https://i.pinimg.com/originals/37/9f/00/379f00ceb97d6a0b0672933022755b3a.png', height: 28, width: 28,),
               const Text('12 LIKE', style: TextStyle(color: Colors.green),)
            ],
          )
        ],
      ),
    );
  }

  Image _buildAvatarDefault() {
    return Image.network(
      'https://vtv1.mediacdn.vn/zoom/550_339/2021/2/7/cristiano-ronaldo-juventus-roma-serie-a-2020-21zilw71maomay1s5qatu94mj4x-1612675293086537648688-crop-1612675298241157948734.jpg',
      height: 48,
      width: 48,
      fit: BoxFit.cover,
    );
  }

  Image _buildAvatar() {
    if (review.authorDetails.avatarPath.contains('https') ||
        review.authorDetails.avatarPath.contains('http')) {
      final String url = review.authorDetails.avatarPath.replaceFirst('/', '');
      return Image.network(
        url,
        height: 48,
        width: 48,
        fit: BoxFit.cover,
        scale: 1.0,
      );
    }
    return Image.network(
      'http://image.tmdb.org/t/p/w500/${review.authorDetails.avatarPath}',
      height: 48,
      width: 48,
      fit: BoxFit.cover,
      scale: 1.0,
    );
  }
}
