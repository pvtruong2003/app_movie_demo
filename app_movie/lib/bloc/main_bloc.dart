import 'package:app_movie/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc extends BaseBloc {
  final _page = BehaviorSubject<int>();

  Stream<int> get page => _page?.stream;

  MainBloc() {
    _page?.sink?.add(0);
  }

  setPage(int page) {
    _page?.sink?.add(page);
  }

  int getPage() {
    return _page?.value;
  }

  @override
  void onDispose() {
    _page?.close();
  }
}
