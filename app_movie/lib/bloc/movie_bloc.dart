import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/locator.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/movies.dart';
import 'package:app_movie/model/list_movie.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:rxdart/rxdart.dart';

typedef NavigatorScreen = void Function(dynamic value);

class MovieBloc extends BaseBloc {

  final ProviderAPI _providerAP = locator<ProviderAPI>();

  final BehaviorSubject<List<Movie>> _movies = BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _searchMovie = BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movies>> _trending = BehaviorSubject<List<Movies>>();

  Stream<List<Movie>> get movies => _movies?.stream;
  Stream<List<Movie>> get searchMovies => _searchMovie?.stream;
  Stream<List<Movies>> get trending => _trending?.stream;

  NavigatorScreen navigatorScreen;
  List<Movie> listMovie = [];

  Future<void> getMovies({int page = 1}) async {
    try {
      final GenericCollection<Movie> data = await _providerAP.getMovies(page);
      if (page == 1) {
         listMovie = data.results;
        _movies?.sink?.add(listMovie);
      } else {
         listMovie.addAll(data.results);
        _movies?.sink?.add(listMovie);
      }
    } on Exception catch (e, st) {
      _movies?.sink?.add(<Movie>[Movie.withError(_providerAP.handleError(e))]);
    }
  }

  Future<void> getTrending(int page) async {
    try {
       final ListTrending data = await _providerAP.getTrending(page);
       _trending?.sink?.add(data.results);
       data.results.forEach((element) {
         print(element.posterPath);
       });
    } on  Exception catch (e, st) {
        _trending?.sink?.add([Movies.withError(_providerAP.handleError(e))]);
        print(_providerAP.handleError(e));
    }
  }

  Future<void> getUpComing(int page) async {
    final ListMovie data = await _providerAP.getMoviesBy(page: 1, path: 'upcoming');
  }

  Future<void> getMovieDetail({String id}) async {
    try {
      final MovieDetail data = await _providerAP.getDetailMovie(id);
      if (data != null){
         navigatorScreen(data);
      }
    } on Exception catch (e, st) {
    }
  }

  List<Movie> getListMovie() {
    return _movies?.value;
  }

  @override
  void onDispose() {
    _movies.close();
    _searchMovie?.close();
    _trending?.close();
  }
}
