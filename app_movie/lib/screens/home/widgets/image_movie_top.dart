import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class ImageMovieTop extends StatelessWidget {
  final MovieDetail movie;
  final VoidCallback onFavoritePressed;

  const ImageMovieTop({Key key, this.movie, this.onFavoritePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColor.black,
      leading: Icon(Icons.arrow_back_rounded),
      actions: [
        IconButton(
          icon: Icon(Icons.ios_share),
          onPressed: () {
            debouncer.run(() {
              if (movie.title != null) {
                Share.share(movie.homepage, subject: movie.title);
              }
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite_border_outlined),
          onPressed: () => onFavoritePressed?.call(),
        ),
      ],
      expandedHeight: 300,
      snap: true,
      floating: true,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: _itemPageViewDefault(movie: movie),
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
              //ToDo check null
              Text(movie.title != null ? movie.title : '',
                  style: TextStyle(
                      color: AppColor.white,
                      fontWeight: AppFontWeight.semiBold,
                      fontSize: AppFontSize.large)),
              const SizedBox(
                height: 8,
              ),

              movie.genres.length > 0 ? _buildGenres() : SizedBox()
            ],
          ),
        )
      ],
    );
  }

  Row _buildGenres() {
    return Row(
      children: movie.genres.map((e) {
        return Container(
          padding: const EdgeInsets.all(4.0),
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(4.0)),
          child: Text(
            e.name,
            style: const TextStyle(color: AppColor.white),
          ),
        );
      }).toList(),
    );
  }


}
