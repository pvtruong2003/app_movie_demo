import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/movie_detail_bloc.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/actor.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/screens/booking/booking_screen.dart';
import 'package:app_movie/screens/home/detail/widgets/item_actor.dart';
import 'package:app_movie/screens/home/detail/widgets/item_similar.dart';
import 'package:app_movie/screens/home/detail/widgets/item_title.dart';
import 'package:app_movie/screens/rate/rate_screen.dart';
import 'package:app_movie/screens/ticket/ticket_screen.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      Actor(name: 'Paul Walker Paul Walker', url: 'https://upload.wikimedia.org/wikipedia/commons/9/91/PaulWalkerEdit-1.jpg'),
      Actor(name: 'Vin Diesel March', url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/VinDieselMarch09.jpg/220px-VinDieselMarch09.jpg'),
      Actor(name: 'Jordana Brewster', url: 'https://media.vanityfair.com/photos/5d177da6734e1f0008f96136/4:3/w_978,h_734,c_limit/fast-9-jordana-brewster.jpg'),
      Actor(name: 'Dwayne Johnson', url: 'https://upload.wikimedia.org/wikipedia/commons/f/f1/Dwayne_Johnson_2%2C_2013.jpg'),
    ];
    Size size = MediaQuery.of(context).size;
    return AppContainer(
        contentBackgroundColor: AppColor.black,
        hidePadding: true,
        child: Stack(
          children: [
            StreamBuilder<MovieDetail>(
              stream: movieDetailBloc.movieDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  movie = snapshot.data;
                  return CustomScrollView(
                    slivers: [

                      SliverAppBar(
                        iconTheme: IconThemeData(color: Colors.white),
                        backgroundColor: AppColor.black,
                        leading: Icon(Icons.arrow_back_rounded),
                        actions: [
                          IconButton(
                            icon: Icon(Icons.ios_share),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border_outlined),
                            onPressed: () {},
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
                      ),

                      SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  '9.4',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: AppFontWeight.medium,
                                      fontSize: AppFontSize.medium),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'Metascore',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontWeight: AppFontWeight.normal,
                                      fontSize: AppFontSize.label),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Icon(
                                  Icons.star_purple500_outlined,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '8.1/10',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: AppFontWeight.medium,
                                      fontSize: AppFontSize.medium),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '189 Reviews',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontWeight: AppFontWeight.normal,
                                      fontSize: AppFontSize.label),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => RateScreen()));
                              },
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Icon(Icons.star_border_rounded),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Rate this',
                                    style: TextStyle(
                                        color: AppColor.white,
                                        fontWeight: AppFontWeight.normal,
                                        fontSize: AppFontSize.label),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: size.width,
                          height: 1,
                          color: AppColor.grayBorder,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: size.width,
                          height: 140,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.network(
                                  movie.backdropPath != null
                                      ?  StringUtils.urlImage(movie.backdropPath)
                                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf3Zf7V-lEXGKscT5U0IZ1qaOG1fjdUrsontkimsoa6NOu0VvACOdOJTXT8vSc4P5Vvb8&usqp=CAU',                                  fit: BoxFit.cover,
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
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          width: size.width,
                          height: 1,
                          color: AppColor.grayBorder,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                        ),
                      ),

                      //ToDo check show content no set height
                      SliverToBoxAdapter(
                        child: Container(
                          height: 200,
                          padding: EdgeInsets.only(
                              left: 16, top: 16, right: 16, bottom: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Storyline',
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontWeight: AppFontWeight.semiBold,
                                      fontSize: AppFontSize.large)),
                              const SizedBox(height: 12,),
                              Text(
                                movie.overview != null ? movie.overview : '',
                                style: TextStyle(
                                    color: AppColor.white,
                                    fontWeight: AppFontWeight.normal,
                                    fontSize: AppFontSize.label),
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4,),
                              Text(
                                'See more',
                                style: TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: AppFontWeight.normal,
                                    fontSize: AppFontSize.text),
                              ),
                              const SizedBox(height: 12,),
                              InkWell(
                                  onTap: () {
                                     _launchUrl(movie.homepage);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                      ),

                      SliverToBoxAdapter(
                        child: Container(
                          width: size.width,
                          height: 1,
                          color: AppColor.grayBorder,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: ButtonBar(
                          mainAxisSize: MainAxisSize.max,
                          buttonHeight: 40,
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Full Cast & Crew', style: TextStyle(
                                color: AppColor.white,
                                fontWeight: AppFontWeight.medium,
                                fontSize: AppFontSize.medium),),
                            Text('SEE ALL', style: TextStyle(
                                color: AppColor.white,
                                fontWeight: AppFontWeight.normal,
                                fontSize: AppFontSize.label),)
                          ],),
                      ),

                      SliverToBoxAdapter(
                        child: Container(
                          height: 220,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: ListView.builder(
                            itemCount: actors.length,
                            padding: EdgeInsets.only(top: 12),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext ctx, int index) {
                              return ItemActor(actor: actors[index],);
                            },
                          ),
                        ),
                      ),


                      SliverToBoxAdapter(
                        child: Container(
                          width: size.width,
                          height: 1,
                          color: AppColor.grayBorder,
                          margin: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: ButtonBar(
                          mainAxisSize: MainAxisSize.max,
                          buttonHeight: 40,
                          alignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Similar Movies', style: TextStyle(
                                color: AppColor.white,
                                fontWeight: AppFontWeight.medium,
                                fontSize: AppFontSize.medium),),
                            Text('SEE ALL', style: TextStyle(
                                color: AppColor.white,
                                fontWeight: AppFontWeight.normal,
                                fontSize: AppFontSize.label),)
                          ],),
                      ),


                      SliverToBoxAdapter(
                        child: StreamBuilder<List<Movie>>(
                          stream: movieDetailBloc.similarMovies,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data[0].error != null) {
                                //ToDo Handle error
                                 return Container(height: 24,);
                              }
                              return Container(
                                height: 320,
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  padding: EdgeInsets.only(top: 12),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return ItemSimilar(movie: snapshot.data[index],);
                                  },
                                ),
                              );
                            }
                            return Container();
                          }
                        ),
                      ),

                    ],
                  );
                }
                return Container();
              }
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: MaterialButton(
                color: Colors.pink,
                minWidth: size.width,
                padding: EdgeInsets.all(14.0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, //Remove space bottom
                onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext ctx) => TicketScreen()));
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                child: Text('Buy Ticker', style: TextStyle(color: AppColor.white, fontWeight: AppFontWeight.medium, fontSize: AppFontSize.medium),),
              ),
            )
          ],
        ));
  }


  Stack _itemPageViewDefault({MovieDetail movie}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          movie.posterPath != null
              ?  StringUtils.urlImage(movie.posterPath)
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

              movie.genres.isNotEmpty
                  ? _buildGenres(movie)
                  : SizedBox()
            ],
          ),
        )
      ],
    );
  }

  Row _buildGenres(MovieDetail movie) {
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

  Future<void>  _launchUrl(String homepage) async {
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

}
