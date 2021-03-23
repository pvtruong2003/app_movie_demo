import 'package:app_movie/bloc/movie_bloc.dart';
import 'package:app_movie/bloc/movie_detail_bloc.dart';
import 'package:app_movie/call_retry.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/screens/movie/widgets/item_richtext.dart';
import 'package:app_movie/screens/movie_detail/widgets/item_company.dart';
import 'package:app_movie/screens/movie_detail/widgets/item_reviews.dart';
import 'package:flutter/material.dart';

class MovieDetail2Screen extends StatefulWidget {
  const MovieDetail2Screen({Key key, this.id}) : super(key: key);

  static const String routerName = '/movie_detail';
  final String id;

  @override
  _MovieDetail2ScreenState createState() => _MovieDetail2ScreenState();
}

class _MovieDetail2ScreenState extends State<MovieDetail2Screen>
    with SingleTickerProviderStateMixin {
  MovieDetailBloc _movieBloc;
  TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    _movieBloc = MovieDetailBloc();
    _movieBloc.getDetails(id: widget.id);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<MovieDetail>(
          stream: _movieBloc.movieDetail,
          builder: (BuildContext context, AsyncSnapshot<MovieDetail> snapshot) {
            if (snapshot.hasData) {
              final MovieDetail movieDetail = snapshot.data;
              if (movieDetail.error != null) {
                return CallRetry(
                  message: movieDetail.error,
                  voidCallback: () {
                    _movieBloc.getDetails(id: widget.id);
                  },
                );
              }
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.cyan,
                    floating: true,
                    pinned: true,
                    snap: true,
                    iconTheme: const IconThemeData(
                      color: Colors.white
                    ),
                    actions: <Widget>[
                      IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {})
                    ],
                    expandedHeight: 280,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        'http://image.tmdb.org/t/p/w500${snapshot.data.posterPath}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate(
                              _buildListContent(snapshot.data)))),

                  // SliverToBoxAdapter(
                  //   child: StreamBuilder<List<Review>>(
                  //     stream: _movieBloc.reviews,
                  //     builder: (BuildContext ctx, AsyncSnapshot<List<Review>> snap) {
                  //       if (snap.hasData) {
                  //         return Container(
                  //           height: MediaQuery.of(context).size.height,
                  //           child: ListView.builder(
                  //               itemCount: snap.data.length,
                  //               itemBuilder: (
                  //                   BuildContext ctx, int index){
                  //                 final Review review = snap.data[index];
                  //                 return ItemReview(review: review,);
                  //               }),
                  //         );
                  //       }
                  //       return Container();
                  //     },
                  //   ),
                  // )

                  // SliverPadding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   sliver: SliverGrid(
                  //     gridDelegate:
                  //     const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       mainAxisSpacing: 10.0,
                  //       crossAxisSpacing: 10.0,
                  //       childAspectRatio: 1.0,
                  //     ),
                  //     delegate: _buildSliverCompany(movieDetail),
                  //   ),
                  // ),

                  // SliverToBoxAdapter(
                  //   child: Column(
                  //     children: <Widget>[
                  //       TabBar(
                  //         tabs: const <Widget>[
                  //           Tab(
                  //             child: Text('Reviews'),
                  //           ),
                  //           Tab(
                  //             child: Text('Production Company'),
                  //           ),
                  //         ],
                  //         onTap: (int index) {
                  //           setState(() {
                  //             _index = index;
                  //           });
                  //         },
                  //         controller: _tabController,
                  //       ),
                  //       Builder(builder: (BuildContext ctx) {
                  //         if (_index == 0) {
                  //           return StreamBuilder<List<Review>>(
                  //             stream: _movieBloc.reviews,
                  //             builder: (BuildContext ctx, AsyncSnapshot<List<Review>> snap) {
                  //               if (snap.hasData) {
                  //                 return Container(
                  //                   height: 400,
                  //                   child: ListView.builder(
                  //                       itemCount: snap.data.length,
                  //                       itemBuilder: (
                  //                           BuildContext ctx, int index){
                  //                         final Review review = snap.data[index];
                  //                         return ItemReview(review: review,);
                  //                       }),
                  //                 );
                  //               }
                  //                return Container();
                  //             },
                  //           );
                  //         } else {
                  //           return Container(
                  //             height: 900,
                  //             child: ListView.builder(
                  //               shrinkWrap: true,
                  //                 itemCount: movieDetail.companies.length,
                  //                 itemBuilder: (BuildContext ctx, int index){
                  //                   return ItemCompany(company: movieDetail.companies[index] ,);
                  //                 }),
                  //           );
                  //         }
                  //       })
                  //     ],
                  //   ),
                  // )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }



  SliverChildBuilderDelegate _buildSliverCompany(MovieDetail movieDetail) {
    return SliverChildBuilderDelegate((BuildContext ctx, int index) {
      return ItemCompany(
        company: movieDetail.companies[index],
      );
    }, childCount: movieDetail.companies.length);
  }

  List<Widget> _buildListContent(MovieDetail movieDetail) {
    final List<Widget> listItems = <Widget>[];
    listItems.add(Text(
      movieDetail.title,
      style: const TextStyle(color: Colors.black, fontSize: 18),
    ));
    listItems.add(const SizedBox(
      height: 8,
    ));
    listItems.add(Text(movieDetail.overview));
    listItems.add(_buildGenres(movieDetail.genres));
    // listItems.add(ItemRichText(
    //     label: 'Rating', data: movieDetail.voteAverage.toString()));
    // listItems.add(
    //     ItemRichText(label: 'Vote', data: movieDetail.voteCount.toString()));
    // listItems.add(const Text(
    //   'Production Company',
    //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    // ));
    final Row titleReview = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget> [
         const Text('Reviews This Movie'),
         TextButton(
             style: TextButton.styleFrom(primary: Colors.white),
             onPressed: (){}, child: const Text('VIEW ALL', style: TextStyle(color: Colors.green),))
      ],
    );
    listItems.add(titleReview);
    listItems.add(StreamBuilder<List<Review>>(
      stream: _movieBloc.reviews,
      builder: (BuildContext ctx, AsyncSnapshot<List<Review>> snap) {
        if (snap.hasData) {
           List<Review> reviews;
          if (snap.data.length >5) {
             reviews =  snap.data.take(3).toList();
          } else {
            reviews = snap.data;
          }
          return Column(children: reviews.map((Review review) => ItemReview(review: review,)).toList(),);
        }
        return Container();
      },
    ));
    return listItems;
  }

  Container _buildGenres(List<Genres> genres) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: genres.length,
          itemBuilder: (BuildContext ctx, int index) {
            return Card(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(child: Text(genres[index].name)),
              ),
            );
          }),
    );
  }
}
