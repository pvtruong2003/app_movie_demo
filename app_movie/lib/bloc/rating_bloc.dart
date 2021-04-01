import 'package:app_movie/common/common.dart';
import 'package:app_movie/main.dart';
import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/locator.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/rating.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class RatingBloc extends BaseBloc {
  final ProviderAPI _providerAP = locator<ProviderAPI>();

  final BehaviorSubject<List<Review>> _review = BehaviorSubject<List<Review>>();
  final BehaviorSubject<Rating> _rating = BehaviorSubject<Rating>();

  Stream<List<Review>> get reviews => _review?.stream;
  Stream<Rating> get rating => _rating?.stream;

  RatingBloc () {
    _rating?.sink?.add(Rating(ratingOne: false, ratingTwo: false, ratingThree: false, ratingFour: false, ratingFive: false));
  }

  updateRating({
    bool isRatingOne = false,
    bool isRatingTwo = false,
    bool isRatingThree = false,
    bool isRatingFour = false,
    bool isRatingFive = false,
  }) {
    _rating?.sink?.add(Rating(
        ratingOne: isRatingOne,
        ratingTwo: isRatingTwo,
        ratingThree: isRatingThree,
        ratingFour: isRatingFour,
        ratingFive: isRatingFive));
  }

  Rating getRating() {
    return _rating?.value;
  }

  Future<void> getReviews({String id}) async {
    try {
      final GenericCollection<Review> data = await _providerAP.getReviews(id);
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
       _review?.sink?.add(<Review>[Review.withError(_providerAP.handleError(e))]);
    }
  }

  Future<void> addRating({String movieId}) async {
    try {
      Common.showLoading(navigatorKey.currentState.context);
      await _providerAP.addRating(id: movieId);
    }  on Exception catch (e, st) {
      Common.hideLoading(navigatorKey.currentState.context);
      print('-------------> ${_providerAP.handleError(e)}');
    }
  }


  String _parseDate(String createdAt) {
    final DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(createdAt);
    final DateTime inputDate = DateTime.parse(parseDate.toString());
    final DateFormat outputFormat = DateFormat('MMM dd, yyyy');
    return outputFormat.format(inputDate);
  }


  @override
  void onDispose() {
     _review?.close();
     _rating?.close();
  }
}
