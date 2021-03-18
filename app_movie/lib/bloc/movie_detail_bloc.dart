
import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/common/common.dart';
import 'package:app_movie/locator.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/cart.dart';
import 'package:app_movie/model/movie.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/movie_rating.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

MovieDetailBloc movieDetailBloc = MovieDetailBloc();

class MovieDetailBloc extends BaseBloc{

  final ProviderAPI _providerAP = locator<ProviderAPI>();

  final BehaviorSubject<List<Movie>> _similarMovie = BehaviorSubject<List<Movie>>();
  final BehaviorSubject<List<Review>> _review = BehaviorSubject<List<Review>>();
  final BehaviorSubject<MovieDetail> _movie = BehaviorSubject<MovieDetail>();
  final BehaviorSubject<MovieRating> _movieRating = BehaviorSubject<MovieRating>();
  final BehaviorSubject<List<Cart>> _cart = BehaviorSubject<List<Cart>>();

  Stream<List<Movie>> get similarMovies => _similarMovie?.stream;
  Stream<List<Review>> get reviews => _review?.stream;
  Stream<MovieDetail> get movieDetail => _movie?.stream;
  Stream<MovieRating> get movieRating => _movieRating?.stream;
  Stream<List<Cart>> get cart => _cart?.stream;

  List<Cart> carts = [
    Cart(time: '08:00'),
    Cart(time: '08:30'),
    Cart(time: '09:00'),
    Cart(time: '09:30'),
    Cart(time: '10:00'),
    Cart(time: '10:30'),
    Cart(time: '11:30'),
    Cart(time: '12:30'),
    Cart(time: '13:30'),
    Cart(time: '14:30'),
    Cart(time: '15:30'),
    Cart(time: '16:30'),
    Cart(time: '17:30'),
    Cart(time: '18:30'),
    Cart(time: '19:30'),
    Cart(time: '20:30'),
    Cart(time: '21:30'),
    Cart(time: '22:30'),
    Cart(time: '23:00'),
    Cart(time: '23:30'),
  ];


  Future<void> getDetails({String id}) async {
    _cart?.sink?.add(carts);
    await Future.wait([getMovieDetail(id: id), getReviews(id: id), getSimilarMovie(id: id)],);
  }

  Future<void> getDetail({String id}) async {
    Common.showLoading(navigatorKey.currentContext);
    await Future.wait([getMovieDetail(id: id), getReviews(id: id), getSimilarMovie(id: id)],);
    Common.hideLoading(navigatorKey.currentContext);
  }

  Future<void> getMovieDetail({String id}) async {
    try {
      final MovieDetail data = await _providerAP.getDetailMovie(id);
      _movie?.sink?.add(data);
    } on Exception catch (e, st) {
      _movie?.sink?.add(MovieDetail.withError(_providerAP.handleError(e)));
    }
  }

  Future<void> getReviews({String id}) async {
    try {
      final GenericCollection<Review> data =
      await _providerAP.getReviews(id);
      final List<Review> reviews = data.results
          .map((Review review) => Review(
          review.id,
          review.author,
          review.content,
          _parseDate(review.createdAt),
          review.authorDetails))
          .toList();
      _review?.sink?.add(reviews);
    } on Exception catch (e, st) {
      _providerAP.handleError(e);
    }
  }

  void updateCart(int index, bool isSelected) {
      carts[index].isSelected = isSelected;
      _cart?.sink?.add(carts);
  }

  List<Cart> getListCart() {
    return _cart.value.where((Cart element) => element.isSelected).toList();
  }

  Future<void> getSimilarMovie({String id}) async{
    try {
      final GenericCollection<Movie> data = await _providerAP.getSimilarMovies(id);
      _similarMovie?.sink?.add(data.results);
    } on Exception catch (e, st) {
      print('Get error --------------> ${_providerAP.handleError(e)}');
      _similarMovie?.sink?.add(<Movie>[Movie.withError(_providerAP.handleError(e))]);
    }
  }

  String _parseDate(String createdAt) {
    final DateTime parseDate =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(createdAt);
    final DateTime inputDate = DateTime.parse(parseDate.toString());
    final DateFormat outputFormat = DateFormat('MMM dd, yyyy');
    return outputFormat.format(inputDate);
  }

  @override
  void onDispose() {
    _movie.close();
    _review?.close();
    _similarMovie?.close();
    _cart?.close();
  }
}
