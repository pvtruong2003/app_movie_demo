import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/locator.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends BaseBloc
{
  final ProviderAPI _providerAP = locator<ProviderAPI>();

  SearchBloc() {
    _searchMovie?.sink?.add([]);
  }

  final BehaviorSubject<List<Movie>> _searchMovie = BehaviorSubject<List<Movie>>();

  Stream<List<Movie>> get searchMovies => _searchMovie?.stream;

  Future<void> searchLocal(String text) async {
    final List<Movie> list = _searchMovie?.value;
    list.where((Movie movie) => movie.title.contains(text)).toList();
    _searchMovie?.sink?.add(list);
  }

  Future<void> onSearchMovies({String text}) async {
    try {
      Common.showLoading(navigatorKey.currentContext);
      final GenericCollection<Movie> data = await _providerAP.searchMovie(text);
      _searchMovie?.sink?.add(data.results);
      Common.hideLoading(navigatorKey.currentContext);
    } on Exception catch (e, st) {
      _providerAP.handleError(e);
      Common.hideLoading(navigatorKey.currentContext);
    }
  }

  @override
  void onDispose() {
    _searchMovie?.close();
  }
}
