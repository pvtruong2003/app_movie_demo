import 'package:app_movie/bloc/base_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:app_movie/model/favorite.dart';

FavoriteBloc favoriteBloc = FavoriteBloc();

class FavoriteBloc extends BaseBloc {
  final BehaviorSubject<List<Favorite>> _favorite =
      BehaviorSubject<List<Favorite>>();

  Stream<List<Favorite>> get favorite => _favorite?.stream;

  Future<void> getFavorite() async {
    List<Favorite> favorites = <Favorite>[];
    Firestore.instance.collection('movies').getDocuments().then((value) {
      for (dynamic item in value.documents) {
        Favorite favorite = Favorite(
            movieId: item['movieId'],
            title: item['title'],
            overview: item['overview'],
            url: item['url']);
        favorites.add(favorite);
      }
      _favorite?.sink?.add(favorites);
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  void onDispose() {
    _favorite?.close();
  }
}