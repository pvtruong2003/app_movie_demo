
import 'dart:convert';

import 'package:app_movie/bloc/base_bloc.dart';
import 'package:app_movie/model/book.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

class BookingBloc extends BaseBloc {
 BehaviorSubject<Book> _book = BehaviorSubject<Book>();
 BehaviorSubject<List<Times>> _times = BehaviorSubject<List<Times>>();

 Stream<Book> get book => _book?.stream;
 Stream<List<Times>> get times => _times?.stream;

  BookingBloc () {
     init();
  }

  Future<void> init() async {
    dynamic data =  await rootBundle.loadString('assets/date.json');
    Book book = Book.fromJson(jsonDecode(data));
    _book?.sink?.add(book);
    Times _time = _book?.value?.times?.first;
    List<Times> time = _book?.value?.times?.where((element) => _time.date == element.date)?.toList();
    _times?.sink?.add(time);
  }

  updateTime({String date}) {
    List<Times> time = _book?.value?.times?.where((element) => date == element.date)?.toList();
    time.forEach((element) {
      element.isSelected = false;
    });
    _times?.sink?.add(time);
  }

 updateSelectTime({Times itemTime, int index}) {
    List<Times> time = _book?.value?.times
        ?.where((element) => itemTime.date == element.date)
        ?.toList();
    time.forEach((element) {
      element.isSelected = false;
    });
    itemTime.isSelected = true;
    time[index] = itemTime;
    _times?.sink?.add(time);
  }

  @override
  void onDispose() {
    _book?.close();
    _times?.close();
  }
  
}