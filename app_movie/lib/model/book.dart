class Book {
  String start;
  String end;
  List<Times> times;

  Book({this.start, this.end, this.times});

  Book.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    if (json['times'] != null) {
      times = [];
      json['times'].forEach((v) {
        times.add(new Times.fromJson(v));
      });
    }
  }
}

class Times {
  String date;
  String time;
  int price;
  bool isSelect;

  Times({this.date, this.time, this.price, this.isSelect = false});

  Times.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    price = json['price'];
    isSelect = false;
  }

}
