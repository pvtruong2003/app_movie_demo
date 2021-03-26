import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/locator.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movies.dart';
import 'package:app_movie/model/list_movie.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc {
  final ProviderAPI _providerAP = locator<ProviderAPI>();

  final BehaviorSubject<List<Movies>> _moviesComing = BehaviorSubject<List<Movies>>();
  final BehaviorSubject<List<Movies>> _moviesNow = BehaviorSubject<List<Movies>>();
  final BehaviorSubject<List<Movies>> _trending = BehaviorSubject<List<Movies>>();
  final BehaviorSubject<List<Movie>> _movies = BehaviorSubject<List<Movie>>();

  Stream<List<Movies>> get moviesComing => _moviesComing?.stream;
  Stream<List<Movie>> get movies => _movies?.stream;
  Stream<List<Movies>> get trending => _trending?.stream;
  Stream<List<Movies>> get moviesNow => _moviesNow?.stream;

  HomeBloc() {
     init();
  }

  Future<void> init() async {
     await Future.wait([getMovieNow(), getMovies(), getMovieComing(), getTrending()]);
  }

  Future<void> getMovieComing({int page = 1 }) async {
    try {
      final ListMovie data =
          await _providerAP.getMoviesBy(page: 1, path: 'upcoming');
      _moviesComing?.sink?.add(data.results);
    } on Exception catch (e, st) {}
  }

  Future<void> getMovieNow({int page = 1}) async {
    try {
      final ListMovie data = await _providerAP.getMoviesBy(page: 1, path: 'now_playing');
      _moviesNow?.sink?.add(data.results);
    } on Exception catch (e, st) {}
  }

  List<Movie> listMovie = [];

  Future<void> getMovies({int page}) async {
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

  Future<void> getTrending({int page = 1}) async {
    try {
      final ListTrending data = await _providerAP.getTrending(page);
      _trending?.sink?.add(data.results);
      data.results.forEach((element) {
        print('Test ${element.title}');
      });
    } on Exception catch (e, st) {
      _trending?.sink?.add([Movies.withError(_providerAP.handleError(e))]);
    }
  }

  @override
  void onDispose() {
    _moviesComing?.close();
    _movies?.close();
    _trending?.close();
    _moviesNow?.close();
  }
}
