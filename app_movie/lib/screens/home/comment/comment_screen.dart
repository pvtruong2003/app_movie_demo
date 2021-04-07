import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/review_bloc.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/screens/home/detail/widgets/item_genres.dart';
import 'package:app_movie/screens/home/widgets/image_movie_top.dart';
import 'package:app_movie/screens/home/widgets/item_rating.dart';
import 'package:app_movie/screens/movie_detail/widgets/item_reviews.dart';
import 'package:app_movie/screens/reviews/add_rating_screen.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:share/share.dart';

class CommentScreen extends StatefulWidget {
  final MovieDetail movieDetail;

  const CommentScreen({Key key, this.movieDetail}) : super(key: key);
  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  MovieDetail movieDetail;
  ReviewBloc reviewBloc;
  @override
  void initState() {
    movieDetail = widget.movieDetail;
    reviewBloc = ReviewBloc();
    reviewBloc.getReviews(id: movieDetail.id.toString());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return AppContainer(
        contentBackgroundColor: AppColor.black,
        hidePadding: true,
        child: CustomScrollView(
          slivers: [
            ImageMovieTop(movie: movieDetail, onFavoritePressed: () => onFavoritePressed(),),
            _buildRating(context),
            _buildSpace(size),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Reviews', style: TextStyle(color: AppColor.white, fontSize: AppFontSize.medium, fontWeight: AppFontWeight.medium),),
                  Text('View All', style: TextStyle(color: AppColor.white, fontSize: AppFontSize.label, fontWeight: AppFontWeight.normal),),
                ],),
              ),
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<List<Review>>(
                 stream: reviewBloc.reviews,
                 builder: (ctx, snapshot) {
                    if (snapshot.hasData) {
                      List<Review> reviews = [];
                      if (snapshot.data.length >5) {
                         reviews = snapshot.data.take(5).toList();
                      } else {
                        reviews = snapshot.data;
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Column(
                          children: reviews.map((e) {
                            return ItemReview(review: e, colorReview: AppColor.white,);

                          }).toList(),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                 },
              ),
            ),
          ],
        ));
  }

  SliverToBoxAdapter _buildSpace(Size size) {
    return SliverToBoxAdapter(
      child: Container(
        width: size.width,
        height: 1,
        color: AppColor.grayBorder,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      ),
    );
  }
  
  SliverToBoxAdapter _buildRating(BuildContext context) {
    return SliverToBoxAdapter(
      child: ItemRating(
        onAddRatingPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AddRatingScreen(
                        movieId: widget.movieDetail.id.toString(),
                        reviewBloc: reviewBloc,
                      )));
        },
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColor.black,
      leading: Icon(Icons.arrow_back_rounded),
      actions: [
        IconButton(
          icon: Icon(Icons.ios_share),
          onPressed: () {
            debouncer.run(() {
              Share.share(movieDetail.homepage, subject: movieDetail.title);
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite_border_outlined),
          onPressed: () {

          },
        ),
      ],
      expandedHeight: 300,
      snap: true,
      floating: true,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: _itemPageViewDefault(movie: movieDetail),
      ),
    );
  }

  Stack _itemPageViewDefault({MovieDetail movie}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          movie.posterPath != null
              ? StringUtils.urlImage(movie.posterPath)
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf3Zf7V-lEXGKscT5U0IZ1qaOG1fjdUrsontkimsoa6NOu0VvACOdOJTXT8vSc4P5Vvb8&usqp=CAU',
          fit: BoxFit.cover,
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.play_circle_outline_outlined,
              color: AppColor.white,
              size: 52,
            )),
        Positioned(
          bottom: 12,
          left: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title != null ? movie.title : '',
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: AppFontSize.large)),
              const SizedBox(
                height: 8,
              ),

               movie.genres.length > 0 ? _buildGenres(movie.genres) : SizedBox()
            ],
          ),
        )
      ],
    );
  }

  _buildGenres(List<Genres> genres) {
    return ItemGenres(genres: genres,);
  }

  onFavoritePressed() {

  }

  @override
  void dispose() {
    super.dispose();
    reviewBloc.onDispose();
  }

}
