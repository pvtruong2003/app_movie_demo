import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/movie_detail_bloc.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/model/actor.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/screens/home/comment/comment_screen.dart';
import 'file:///D:/BSTAR/movie/app_movie/lib/screens/home/booking/booking_movie.dart';
import 'package:app_movie/screens/home/detail/widgets/item_actor.dart';
import 'package:app_movie/screens/home/detail/widgets/item_similar.dart';
import 'package:app_movie/screens/home/detail/widgets/item_title.dart';
import 'package:app_movie/screens/home/widgets/image_movie_top.dart';
import 'package:app_movie/screens/home/widgets/item_rating.dart';
import 'package:app_movie/screens/home/widgets/navigator_screen.dart';
import 'package:app_movie/screens/reviews/add_rating_screen.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeMovieDetail extends StatefulWidget {
  final String id;

  const HomeMovieDetail({Key key, this.id}) : super(key: key);

  @override
  _HomeMovieDetailState createState() => _HomeMovieDetailState();
}

class _HomeMovieDetailState extends State<HomeMovieDetail> {
  MovieDetail movie;

  @override
  void initState() {
    super.initState();
    movieDetailBloc.init(id: widget.id);
    //ToDo homepage open url
  }

  @override
  Widget build(BuildContext context) {
    List<Actor> actors = [
      Actor(
          name: 'Paul Walker Paul Walker',
          url:
              'https://upload.wikimedia.org/wikipedia/commons/9/91/PaulWalkerEdit-1.jpg'),
      Actor(
          name: 'Vin Diesel March',
          url:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/VinDieselMarch09.jpg/220px-VinDieselMarch09.jpg'),
      Actor(
          name: 'Jordana Brewster',
          url:
              'https://media.vanityfair.com/photos/5d177da6734e1f0008f96136/4:3/w_978,h_734,c_limit/fast-9-jordana-brewster.jpg'),
      Actor(
          name: 'Dwayne Johnson',
          url:
              'https://upload.wikimedia.org/wikipedia/commons/f/f1/Dwayne_Johnson_2%2C_2013.jpg'),
    ];
    Size size = MediaQuery.of(context).size;
    return AppContainer(
        contentBackgroundColor: AppColor.black,
        containerBackgroundColor: AppColor.black,
        hidePadding: true,
        child: Stack(
          children: [
            StreamBuilder<MovieDetail>(
                stream: movieDetailBloc.movieDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Container();
                    }
                    movie = snapshot.data;
                    return CustomScrollView(
                      slivers: [
                        ImageMovieTop(
                          movie: movie,
                          onFavoritePressed: () => onFavoritePressed(movie),
                        ),
                        buildRating(context, movie),
                        _buildSpace(size),
                        _buildContentMovie(size),
                        _buildSpace(size),
                        _buildStoryline(),
                        _buildSpace(size),
                        _buildTitleActor(),
                        _buildActors(actors),
                        _buildSpace(size),
                        _buildTitleSimilarMovie(),
                        _buildSimilarMovies(),
                      ],
                    );
                  }
                  return Container();
                }),
            _buildButtonBuyTicket(context),
          ],
        ));
  }

  Align _buildButtonBuyTicket(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: NavigatorScreen(
        textButton: 'BUY TICKET',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext ctx) => BookingMovie(
                        movieDetailBloc: movieDetailBloc,
                      )));
        },
      ),
    );
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

  SliverToBoxAdapter _buildSimilarMovies() {
    return SliverToBoxAdapter(
      child: StreamBuilder<List<Movie>>(
          stream: movieDetailBloc.similarMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.isNotEmpty) {
              if (snapshot.data[0].error != null) {
                return Container(
                  height: 24,
                );
              }
              return Container(
                height: 320,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  padding: EdgeInsets.only(top: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext ctx, int index) {
                    return ItemSimilar(
                      movie: snapshot.data[index],
                    );
                  },
                ),
              );
            }
            return Container();
          }),
    );
  }

  SliverToBoxAdapter _buildTitleSimilarMovie() {
    return SliverToBoxAdapter(
      child: ButtonBar(
        mainAxisSize: MainAxisSize.max,
        buttonHeight: 40,
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Similar Movies',
            style: TextStyle(
                color: AppColor.white,
                fontWeight: AppFontWeight.medium,
                fontSize: AppFontSize.medium),
          ),
          Text(
            'SEE ALL',
            style: TextStyle(
                color: AppColor.white,
                fontWeight: AppFontWeight.normal,
                fontSize: AppFontSize.label),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildActors(List<Actor> actors) {
    return SliverToBoxAdapter(
      child: Container(
        height: 220,
        padding: EdgeInsets.only(left: 16, right: 16),
        child: ListView.builder(
          itemCount: actors.length,
          padding: EdgeInsets.only(top: 12),
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext ctx, int index) {
            return ItemActor(
              actor: actors[index],
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildTitleActor() {
    return SliverToBoxAdapter(
      child: ButtonBar(
        mainAxisSize: MainAxisSize.max,
        buttonHeight: 40,
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Full Cast & Crew',
            style: TextStyle(
                color: AppColor.white,
                fontWeight: AppFontWeight.medium,
                fontSize: AppFontSize.medium),
          ),
          Text(
            'SEE ALL',
            style: TextStyle(
                color: AppColor.white,
                fontWeight: AppFontWeight.normal,
                fontSize: AppFontSize.label),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildStoryline() {
    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Storyline',
                style: TextStyle(
                    color: AppColor.white,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: AppFontSize.large)),
            const SizedBox(
              height: 12,
            ),
            Text(
              movie.overview != null ? movie.overview : '',
              style: TextStyle(
                  color: AppColor.white,
                  fontWeight: AppFontWeight.normal,
                  fontSize: AppFontSize.label),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'See more',
              style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: AppFontWeight.normal,
                  fontSize: AppFontSize.text),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                _launchUrl(movie.homepage);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Website',
                      style: TextStyle(
                          color: AppColor.white,
                          fontWeight: AppFontWeight.normal,
                          fontSize: AppFontSize.label)),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildContentMovie(Size size) {
    return SliverToBoxAdapter(
      child: Container(
        width: size.width,
        height: 140,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                movie.backdropPath != null
                    ? StringUtils.urlImage(movie.backdropPath)
                    : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf3Zf7V-lEXGKscT5U0IZ1qaOG1fjdUrsontkimsoa6NOu0VvACOdOJTXT8vSc4P5Vvb8&usqp=CAU',
                fit: BoxFit.cover,
                width: 98,
                height: 160,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8,
                ),
                ItemTitle(
                  title: 'Title',
                  text: 'Dunkirk',
                ),
                ItemTitle(
                  title: 'Running Time',
                  text: '1h 45min',
                ),
                ItemTitle(
                  title: 'Release Date',
                  text: Common.parseToDate(date: movie.releaseDate),
                ),
                ItemTitle(
                  title: 'Director',
                  text: 'Christopher Nolan',
                ),
                ItemTitle(
                  title: 'Writer',
                  text: 'Christopher Nolan',
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter buildRating(BuildContext context, MovieDetail movie) {
    return SliverToBoxAdapter(
      child: ItemRating(
        onRatingPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => CommentScreen(
                    movieDetail: movie,
                  )));
        },
        onAddRatingPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => AddRatingScreen()));
        },
      ),
    );
  }


  Future<void> _launchUrl(String homepage) async {
    print(homepage);
    if (await canLaunch(homepage)) {
      await launch(
        homepage,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $homepage';
    }
  }

  onFavoritePressed(MovieDetail movie) {

  }
}
