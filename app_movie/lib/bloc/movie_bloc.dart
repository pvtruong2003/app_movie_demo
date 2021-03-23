import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/locator.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:rxdart/rxdart.dart';
typedef NavigatorScreen = void Function(dynamic value);

class MovieBloc extends BaseBloc{

  final ProviderAPI _providerAP = locator<ProviderAPI>();

  final BehaviorSubject<List<Movie>> _movies = BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Movie>> _searchMovie = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get movies => _movies?.stream;

  Stream<List<Movie>> get searchMovies => _searchMovie?.stream;

  NavigatorScreen navigatorScreen;

  Future<void> getMovies({int page}) async {
    try {
      final GenericCollection<Movie> data = await _providerAP.getMovies(page);
      _movies?.sink?.add(data.results);
    } on Exception catch (e, st) {
      _movies?.sink?.add(<Movie>[Movie.withError(_providerAP.handleError(e))]);
    }
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

  @override
  void onDispose() {
    _movies.close();
    _searchMovie?.close();
  }
}
