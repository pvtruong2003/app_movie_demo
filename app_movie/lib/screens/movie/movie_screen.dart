import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/movie_bloc.dart';
import 'package:app_movie/call_retry.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/screens/booking/booking_screen.dart';
import 'package:app_movie/screens/movie/widgets/item_movie.dart';
import 'package:app_movie/screens/movie/widgets/item_top.dart';
import 'package:app_movie/screens/movie_detail/movie_detail_screen.dart';
import 'package:app_movie/screens/view_more/view_more_movie.dart';
import 'package:app_movie/wigets/list_item_builder.dart';
import 'package:flutter/material.dart';

class MovieScreen extends StatefulWidget {
  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with AutomaticKeepAliveClientMixin<MovieScreen>{
  MovieBloc _movieBloc;
  int _page = 1;
  var _controller  = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    _movieBloc = MovieBloc();
    _movieBloc.getMovies(page: _page);
    _movieBloc.getTrending(_page);
    _movieBloc.getUpComing(_page);
    super.initState();
    _controller.addListener(() {
         double maxScroll = _controller.position.maxScrollExtent;
         double currentScroll  = _controller.position.pixels;
         double delta = 200.0;
         if (maxScroll - currentScroll <= delta) {
            _page++;
            _movieBloc.getMovies(page: _page);
         }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _movieBloc.navigatorScreen = navigatorScreen;
    TextStyle textStyle = TextStyle(color: AppColor.black, fontSize: AppFontSize.large, fontWeight: AppFontWeight.semiBold);
    TextStyle textStyleView = TextStyle(color: Colors.pink, fontSize: AppFontSize.small, fontWeight: AppFontWeight.normal);
    return AppContainer(
      hidePadding: true,
      key: PageStorageKey('MovieScreen'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: Icon(Icons.menu),
        actions: [
          Container(
            height: 36,
            width: 36,
            margin: EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCe_o8_IQuNtFocDhlA6xVDAZ0CeM0fa2B3g&usqp=CAU')
                )
            ),
          )
        ],
      ),
      child: StreamBuilder<List<Movie>>(
        stream: _movieBloc.movies,
        builder: (BuildContext ctx, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasData) {
            List<Movie> movies = snapshot.data;
            if (snapshot.data[0].error != null) {
              return CallRetry(
                message: snapshot.data[0].error,
                hideAppbar: false,
                voidCallback: () async{
                  _movieBloc.getMovies(page: _page);
                },
              );
            }
            return CustomScrollView(
                controller: _controller,
                slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 16),
                  margin: EdgeInsets.only(bottom: 8, top: 16),
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: ListView.builder(
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                           return ItemTop(movie: movies[index],);
                      }),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 4, left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Trending', style: textStyle,),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => ViewMoreMovie()));
                          },
                          child: Text('View more', style: textStyleView,)),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.only(bottom: 24),
                sliver: SliverFixedExtentList(
                    delegate: SliverChildBuilderDelegate((BuildContext ctx, int index) {
                      Movie movie = snapshot.data[index];
                      return buildRow(movie);
                    }, childCount: snapshot.data.length,), itemExtent: 140),
              ),
            ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );

    return AppContainer(
      hidePadding: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: Icon(Icons.menu),
        actions: [
          Container(
            height: 36,
            width: 36,
            margin: EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRCe_o8_IQuNtFocDhlA6xVDAZ0CeM0fa2B3g&usqp=CAU')
              )
            ),
          )
        ],
      ),
      child: RefreshIndicator(
        onRefresh: () async {
          _movieBloc.getMovies(page: _page);
        },
        child: StreamBuilder<List<Movie>>(
          stream: _movieBloc.movies,
          builder: (BuildContext ctx, AsyncSnapshot<List<Movie>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0].error != null) {
                return CallRetry(
                  message: snapshot.data[0].error,
                  hideAppbar: false,
                  voidCallback: () async{
                    _movieBloc.getMovies(page: _page);
                  },
                );
              }
              return ListItemBuilder<Movie>(
                items: snapshot.data,
                itemBuilder: (BuildContext ctx, Movie movie) {
                  return ItemMovie(
                    movie: movie,
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  GestureDetector buildRow(Movie movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => MovieDetailScreen(id: movie.id.toString(),)));
      },
      child: Row(
        children: [
          Container(
            height: 140,
            width: 100,
            margin: EdgeInsets.only(left: 16, right: 12, top: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'http://image.tmdb.org/t/p/w500${movie.posterPath}'))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24,),
                Text(
                  movie.title,
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: AppFontSize.medium,
                      fontWeight: AppFontWeight.medium),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Colors.yellow,),
                    Icon(Icons.star, size: 16, color: Colors.yellow,),
                    Icon(Icons.star, size: 16, color: Colors.yellow,),
                    Icon(Icons.star, size: 16, color: Colors.yellow,),
                    Icon(Icons.star, size: 16, color: Colors.grey,),
                  ],
                ),
                SizedBox(height: 8,),
                Text(
                  'Action, Adventure, Fantasy, Science Fiction',
                  style: TextStyle(
                      color: Colors.black26,
                      fontSize: AppFontSize.text,
                      fontWeight: AppFontWeight.normal),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(child: Container()),
                GestureDetector(
                    onTap: () {
                       _movieBloc.getMovieDetail(id: movie.id.toString());
                    },
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.pink,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;

  void navigatorScreen(value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => BookingScreen(movie: value,)));
  }
}
