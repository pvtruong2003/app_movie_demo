import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/home_bloc.dart';
import 'package:app_movie/call_retry.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/loading.dart';
import 'package:app_movie/model/movies.dart';
import 'package:app_movie/model/movies_home.dart';
import 'package:app_movie/screens/home/detail/home_movie_detail.dart';
import 'package:app_movie/screens/home/item_trending.dart';
import 'package:app_movie/screens/home/search/search_movie_screen.dart';
import 'package:app_movie/screens/view_more/view_more_movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;
  @override
  void initState() {
    _homeBloc = HomeBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 6);
    TextStyle textStyle = TextStyle(color: AppColor.white, fontSize: AppFontSize.large, fontWeight: AppFontWeight.semiBold);
    TextStyle textStyleView = TextStyle(color: Colors.white, fontSize: AppFontSize.label, fontWeight: AppFontWeight.normal);

    return AppContainer(
      hidePadding: true,
      isStatusBar: false,
      contentBackgroundColor: AppColor.black,
      containerBackgroundColor: AppColor.black,
      child: StreamBuilder<MovieHome>(
        stream: _homeBloc.moviesHome,
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            if (snapshot.data.error != null) {
              return CallRetry(
                  hideAppbar: false,
                  message: snapshot.data.error,
                  voidCallback: () {
                     Common.showLoading(context);
                    _homeBloc.getAllMovies();
                     Common.hideLoading(context);
                  },
                );
              }
            List<Movies> moviesNow = snapshot.data.moviesNow;
            List<Movies> moviesComing = snapshot.data.moviesComing;
            List<Movies> moviesTrending = snapshot.data.moviesTrending;
            return CustomScrollView(
              slivers: [

                _buildSliverAppBar2(controller, moviesNow),

                SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 4, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Trending',
                            style: textStyle,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => ViewMoreMovie()));
                              },
                              child: Text(
                                'SEE ALL ',
                                style: textStyleView,
                              )),
                        ],
                      ),
                    )),
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    margin: EdgeInsets.only(bottom: 8, top: 16),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    child: ListView.builder(
                        itemCount: moviesTrending.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          Movies movie = moviesTrending[index];
                          return ItemTrending(
                            movie: movie,
                          );
                        }),
                  )
                ),

                SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 4, left: 16, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Coming soon', style: textStyle,),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (ctx) => ViewMoreMovie()));
                              },
                              child: Text('SEE ALL ', style: textStyleView,)),
                        ],
                      ),
                    )
                ),
                  SliverToBoxAdapter(
                      child: Container(
                        padding: EdgeInsets.only(left: 16),
                        margin: EdgeInsets.only(bottom: 8, top: 16),
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                            itemCount: moviesComing.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              Movies movie = moviesComing[index];
                              return ItemTrending(
                                movie: movie,
                              );
                        }),
                  )),
                ],
            );
          }

          return Center(child: CircularProgressIndicator(),);

        }
      ),
    );

    // return AppContainer(
    //   hidePadding: true,
    //   isStatusBar: false,
    //   contentBackgroundColor: Colors.black,
    //   child: CustomScrollView(
    //      slivers: [
    //         _buildSliverAppBar(controller),
    //        SliverToBoxAdapter(
    //          child: StreamBuilder<List<Movies>>(
    //              stream: _homeBloc.trending,
    //              builder: (context, snapshot) {
    //               if (snapshot.hasData) {
    //                 if (snapshot.data.first.error != null) {
    //                   return Container();
    //                 }
    //                 return Padding(
    //                   padding: const EdgeInsets.only(
    //                       top: 20, bottom: 4, left: 16, right: 16),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text('Trending', style: textStyle,),
    //                       GestureDetector(
    //                           onTap: () {
    //                             Navigator.push(context, MaterialPageRoute(
    //                                 builder: (ctx) => ViewMoreMovie()));
    //                           },
    //                           child: Text('SEE ALL ', style: textStyleView,)),
    //                     ],
    //                   ),
    //                 );
    //               }
    //               return SizedBox.shrink();
    //            }
    //          ),
    //        ),
    //
    //       SliverToBoxAdapter(
    //         child: StreamBuilder<List<Movies>>(
    //             stream: _homeBloc.trending,
    //             builder: (context, snapshot) {
    //               if (snapshot.hasData) {
    //                 if (snapshot.data.first.error != null) {
    //                   return SizedBox.shrink();
    //                 }
    //                 return Container(
    //                   padding: EdgeInsets.only(left: 16),
    //                   margin: EdgeInsets.only(bottom: 8, top: 16),
    //                   height: MediaQuery.of(context).size.height * 0.4,
    //                   child: ListView.builder(
    //                       itemCount: snapshot.data.length,
    //                       scrollDirection: Axis.horizontal,
    //                       itemBuilder: (ctx, index) {
    //                         Movies movie = snapshot.data[index];
    //                         return ItemTrending(
    //                           movie: movie,
    //                         );
    //                       }),
    //                 );
    //               }
    //               return Loading();
    //             }),
    //       ),
    //
    //       SliverToBoxAdapter(
    //          child: StreamBuilder<List<Movies>>(
    //            stream: _homeBloc.moviesComing,
    //            builder: (context, snapshot) {
    //              if (snapshot.hasData) {
    //                if (snapshot.data.first.error != null) {
    //                  return SizedBox.shrink();
    //                }
    //                return Padding(
    //                  padding: const EdgeInsets.only(
    //                      top: 20, bottom: 4, left: 16, right: 16),
    //                  child: Row(
    //                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                    children: [
    //                      Text('Coming soon', style: textStyle,),
    //                      GestureDetector(
    //                          onTap: () {
    //                            Navigator.push(context, MaterialPageRoute(
    //                                builder: (ctx) => ViewMoreMovie()));
    //                          },
    //                          child: Text('SEE ALL ', style: textStyleView,)),
    //                    ],
    //                  ),
    //                );
    //              }
    //              return SizedBox.shrink();
    //            }
    //          ),
    //        ),
    //        SliverToBoxAdapter(
    //          child: StreamBuilder<List<Movies>>(
    //              stream: _homeBloc.moviesComing,
    //              builder: (context, snapshot) {
    //                if (snapshot.hasData) {
    //                  if (snapshot.data.first.error != null) {
    //                    return SizedBox.shrink();
    //                  }
    //                  return Container(
    //                    padding: EdgeInsets.only(left: 16),
    //                    margin: EdgeInsets.only(bottom: 8, top: 16),
    //                    height: MediaQuery.of(context).size.height * 0.4,
    //                    child: ListView.builder(
    //                        itemCount: snapshot.data.length,
    //                        scrollDirection: Axis.horizontal,
    //                        itemBuilder: (ctx, index) {
    //                          Movies movie = snapshot.data[index];
    //                          return ItemTrending(
    //                            movie: movie,
    //                          );
    //                        }),
    //                  );
    //                }
    //                return Loading();
    //              }),
    //        ),
    //
    //      ],
    //   ),
    // );
  }

  SliverAppBar _buildSliverAppBar2(PageController controller, List<Movies> movies) {
    return SliverAppBar(
      backgroundColor: Colors.black,
      iconTheme: const IconThemeData(color: AppColor.white),
      pinned: true,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => SearchMovieScreen())),
            icon: Icon(Icons.search)),
      ],
      leading: Icon(Icons.menu),
      expandedHeight: 300,
      flexibleSpace: FlexibleSpaceBar(
        background: PageView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          children: movies.map((item) => _itemPageView(item)).toList(),
        ),
      ),
    );
  }


  SliverAppBar _buildSliverAppBar(PageController controller) {
    return SliverAppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: AppColor.white),
            pinned: true,
            elevation: 0,
            actions: [
               Padding(
                 padding: const EdgeInsets.only(left: 16, right: 16),
                 child: Icon(Icons.search),
               )
            ],
            leading: Icon(Icons.menu),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: StreamBuilder<List<Movies>>(
                stream: _homeBloc.moviesNow,
                builder: (context, snapshot) {
                  print('PageView ${snapshot.data}');
                  if (snapshot.hasData) {
                    if (snapshot.data.first.error != null) {
                      return SizedBox.shrink();
                    }
                    return PageView(
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      children: snapshot.data.map((item) => _itemPageView(item)).toList(),
                    );
                  }
                  return Container();
                }
              ),
            ),

          );
  }

  Stack _itemPageView(Movies movie) {
    return Stack(
      fit: StackFit.expand,
      children: [
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomeMovieDetail(id: movie.id.toString(),))),
          child: Image.network(
            'http://image.tmdb.org/t/p/w500/${movie.posterPath}',
            fit: BoxFit.cover,
          ),
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
              Text(
                movie.title,
                style: TextStyle(
                    color: AppColor.white,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: AppFontSize.large),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    '189 Reviews',
                    style: TextStyle(
                        color: AppColor.white,
                        fontWeight: AppFontWeight.medium,
                        fontSize: AppFontSize.medium),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      'THRILLER',
                      style: const TextStyle(color: AppColor.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      'ACTION',
                      style: const TextStyle(color: AppColor.white),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Stack _itemPageViewDefault() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQf3Zf7V-lEXGKscT5U0IZ1qaOG1fjdUrsontkimsoa6NOu0VvACOdOJTXT8vSc4P5Vvb8&usqp=CAU',
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
              Text(
                'Terminator 2: Judgment Day (1991)',
                style: TextStyle(
                    color: AppColor.white,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: AppFontSize.large),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 14,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    '189 Reviews',
                    style: TextStyle(
                        color: AppColor.white,
                        fontWeight: AppFontWeight.medium,
                        fontSize: AppFontSize.medium),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      'THRILLER',
                      style: const TextStyle(color: AppColor.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    margin: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Text(
                      'ACTION',
                      style: const TextStyle(color: AppColor.white),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

}
