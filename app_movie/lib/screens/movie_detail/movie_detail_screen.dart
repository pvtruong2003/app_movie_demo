import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/movie_detail_bloc.dart';
import 'package:app_movie/display_connect_internet.dart';
import 'package:app_movie/model/cart.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/screens/movie_detail/widgets/item_all.dart';
import 'package:app_movie/screens/movie_detail/widgets/item_reviews.dart';
import 'package:flutter/material.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({Key key, this.id}) : super(key: key);

  static const String routerName = '/movie_detail';
  final String id;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);
  @override
  void initState() {
    movieDetailBloc.getDetails(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      hidePadding: true,
      child: StreamBuilder<MovieDetail>(
          stream: movieDetailBloc.movieDetail,
          builder: (BuildContext context, AsyncSnapshot<MovieDetail> snapshot) {
            if (snapshot.hasData) {
              final MovieDetail movieDetail = snapshot.data;
              if (movieDetail.error != null) {
                return DisplayConnectInternet(
                  message: movieDetail.error,
                  voidCallback: () {
                    movieDetailBloc.getDetails(id: widget.id);
                  },
                );
              }
              return CustomScrollView(
                slivers: <Widget>[
                  _buildAppBar(snapshot),
                  SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      sliver: SliverList(
                          delegate: SliverChildListDelegate(
                              _buildListContent(snapshot.data)))),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
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
    listItems.add(const Text(
      'Similar movies',
      style: TextStyle(fontSize: 16),
    ));
    listItems.add(const SizedBox(
      height: 8,
    ));
    listItems.add(_buildSimilar());
    listItems.add(const SizedBox(
      height: 8,
    ));
    listItems.add(_buildTitleReview());
    listItems.add(_buildReview());
    return listItems;
  }

  StreamBuilder<List<Movie>> _buildSimilar() {
    return StreamBuilder<List<Movie>>(
        stream: movieDetailBloc.similarMovies,
        builder: (BuildContext ctx, AsyncSnapshot<List<Movie>> snap) {
          if (snap.hasData) {
            List<Movie> items;
            if (snap.data.length > 5) {
              items = snap.data.take(5).toList();
            } else {
              items = snap.data;
            }
            return Container(
              height: 120,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      items.length >= 5 ? items.length + 1 : items.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (index == items.length) {
                      return ItemAll(
                        movieDetailBloc: movieDetailBloc,
                      );
                    }
                    final Movie movie = items[index];
                    return GestureDetector(
                      onTap: () {
                        isFavorite.value = false;
                        movieDetailBloc.getDetail(id: movie.id.toString());
                      },
                      child: Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                                height: 120,
                                width: 110,
                                margin: const EdgeInsets.only(right: 12.0),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8.0)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'http://image.tmdb.org/t/p/w500${movie.posterPath}')))),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
          return Container();
        });
  }

  SliverAppBar _buildAppBar(AsyncSnapshot<MovieDetail> snapshot) {
    print('------------------------>');
    return SliverAppBar(
      backgroundColor: Colors.cyan,
      floating: true,
      pinned: true,
      snap: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: <Widget>[
        IconButton(
            icon: ValueListenableBuilder<bool>(
                valueListenable: isFavorite,
                builder: (BuildContext ctx, bool isSelected, Widget child) {
                  if (isSelected) {
                    return const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    );
                  }
                  return const Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                  );
                }),
            onPressed: () {
              isFavorite.value = !isFavorite.value;
            }),
        Stack(
          children: [
            IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.red,
                ),
                onPressed: () {
                  _showModalBottomTime();
                }),
            Positioned(
              top: 4,
              right: 6,
              child: StreamBuilder<List<Cart>>(
                  stream: movieDetailBloc.cart,
                  builder: (BuildContext context, AsyncSnapshot<List<Cart>> snapshot) {

                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle
                      ),
                      child: Text(snapshot.data.where((Cart element) => element.isSelected).toList().length.toString(), style: const TextStyle(color: Colors.white),),
                    );
                  }
              ),
            ),

          ],
        ),
      ],
      expandedHeight: 280,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          'http://image.tmdb.org/t/p/w500${snapshot.data.posterPath}',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<void> _showModalBottomTime() {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Select time',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: StreamBuilder<List<Cart>>(
                      stream: movieDetailBloc.cart,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Cart>> snapshot) {
                        return ListView.separated(
                            shrinkWrap: false,
                            separatorBuilder: (BuildContext ctx, int index) =>
                                const Divider(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              final Cart cart = snapshot.data[index];
                              return GestureDetector(
                                onTap: () {
                                  movieDetailBloc.updateCart(
                                      index, !cart.isSelected);
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 8, left: 16, bottom: 8, right: 16),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(cart.time),
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: cart.isSelected
                                              ? Colors.cyan.withOpacity(0.5)
                                              : Colors.grey,
                                        )
                                      ],
                                    )),
                              );
                            });
                      }),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: MaterialButton(
                      minWidth: double.infinity,
                      padding: const EdgeInsets.all(4.0),
                      onPressed: () {
                       // _movieBloc.getListCart();
                      },
                      color: Colors.cyan,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  StreamBuilder<List<Review>> _buildReview() {
    return StreamBuilder<List<Review>>(
      stream: movieDetailBloc.reviews,
      builder: (BuildContext ctx, AsyncSnapshot<List<Review>> snap) {
        if (snap.hasData) {
          List<Review> reviews;
          if (snap.data.length > 5) {
            reviews = snap.data.take(3).toList();
          } else {
            reviews = snap.data;
          }
          return Column(
            children: reviews
                .map((Review review) => ItemReview(
                      review: review,
                    ))
                .toList(),
          );
        }
        return Container();
      },
    );
  }

  Row _buildTitleReview() {
    final Row titleReview = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        const Text('Reviews This Movie'),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            onPressed: () {},
            child: const Text(
              'VIEW ALL',
              style: TextStyle(color: Colors.green),
            ))
      ],
    );
    return titleReview;
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
