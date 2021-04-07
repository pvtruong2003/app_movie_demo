import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/locator.dart';
import 'package:app_movie/model/base_response/generic_collection.dart';
import 'package:app_movie/model/reviews.dart';
import 'package:app_movie/service/provider_api.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

class ReviewBloc extends BaseBloc {
  final ProviderAPI _providerAP = locator<ProviderAPI>();
  final BehaviorSubject<List<Review>> _review = BehaviorSubject<List<Review>>();
  Stream<List<Review>> get reviews => _review?.stream;

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
      _providerAP.handleError(e);
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
  }

}