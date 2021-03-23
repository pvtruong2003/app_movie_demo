import 'package:app_movie/app_bar.dart';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/common/widgets/item_booking.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/screens/booking/widgets/item_date.dart';
import 'package:app_movie/screens/booking/widgets/item_time.dart';
import 'package:app_movie/screens/check_out/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key key, this.movie}) : super(key: key);

  final MovieDetail movie;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<String> times = ['09:00', '10:00', '11:00','12:00', '13:00', '14:00','15:00', '16:00', '17:00',];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<DateTime> calculateDaysInterval(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> dateTimes = calculateDaysInterval(DateTime.now(), DateTime(2021, 4, 30, 0,0));
    return AppContainer(
        appBar: customAppBar(
            leading: true,
            title: 'Booking', centerTitle: true),
        child: ListView(
          children: [
           // Text('Lotte Cinema'),
            Text(widget.movie.title, style: TextStyle(fontSize: AppFontSize.large, fontWeight: AppFontWeight.semiBold),),
            _buildRowTime(),
            Container(
             height: 300,
              // child: Wrap(
              //   spacing: 4,
              //   runSpacing: 4,
              //   children: List.generate(50, (index) => Container(
              //     padding: EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //         color: Colors.grey,
              //         borderRadius: BorderRadius.circular(8)
              //       ),
              //       child: Text('S$index'))),
              // ),
           ),
          _buildListDate(dateTimes),
          _buildListTime()
        ],
        ),
        bottomNavigationBar: buildBottomBar(context),
    );
  }

  Container _buildListTime() {
    return Container(
            height: 40,
            margin: EdgeInsets.only(top: 24),
            child: ListView.builder(
              itemCount: times.length,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => ItemTime(time: times[index],),
            ),
          );
  }

  Container _buildListDate(List<DateTime> dateTimes) {
    return Container(
             height: 72,
             child: ListView.builder(
               itemCount: dateTimes.length,
               padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
               scrollDirection: Axis.horizontal,
               itemBuilder: (ctx, index) {
                 String month = DateFormat("MMM").format(dateTimes[index]);
                 String day = DateFormat("dd").format(dateTimes[index]);
                 return ItemDate(month: month, day: day,);
               },
             ),
           );
  }

  Padding buildBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 20),
      child: MaterialButton(
        padding: EdgeInsets.all(12.0),
        color: Colors.pinkAccent,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Text(
          'Confirm',
          style: TextStyle(
              color: AppColor.white,
              fontSize: AppFontSize.medium,
              fontWeight: AppFontWeight.medium),
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext ctx) {
                return Container(
                  color: Colors.transparent,
                  child: Container(
                    height: 230,
                    padding: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 24),
                          child: Text(
                            widget.movie.title,
                            style: TextStyle(
                                fontSize: AppFontSize.medium,
                                fontWeight: AppFontWeight.medium),
                          ),
                        ),
                        Expanded(child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ItemBooking(
                              label: 'Date',
                              text: '26.03',
                            ),
                            ItemBooking(
                              label: 'Time',
                              text: '2h30',
                            ),
                            ItemBooking(
                              label: 'Seats',
                              text: '7,8',
                            ),
                            ItemBooking(
                              label: 'Row',
                              text: '5',
                            ),
                          ],
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Price\n',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: AppFontWeight.normal,
                                          fontSize: AppFontSize.text),
                                      children: [
                                    TextSpan(
                                      text: '47,50',
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontWeight: AppFontWeight.medium,
                                          fontSize: AppFontSize.medium),
                                    )
                                  ])),
                            ),
                            MaterialButton(
                              onPressed: () {
                                Navigator.pop(
                                    context); //Hide showModalBottomSheet
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => CheckOutScreen(movie: widget.movie,)));
                              },
                              child: Text(
                                'Check out',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: AppFontWeight.medium,
                                    fontSize: AppFontSize.medium),
                              ),
                              color: Colors.pinkAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20))),
                              minWidth: MediaQuery.of(context).size.width / 2,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(vertical: 16),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }

  Row _buildRowTime() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
              TextButton.icon(
                  style:  TextButton.styleFrom(
                    primary: AppColor.white,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0)
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.location_on_rounded, color: AppColor.black,),
                  label: Text('Lotte Cinema', style: TextStyle(color: Colors.cyan),)),
              TextButton.icon(
                  style:  TextButton.styleFrom(
                      primary: AppColor.white,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0)
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.timer, color: AppColor.black,),
                  label: Text('2h 45min', style: TextStyle(color: Colors.cyan),))
            ],
          );
  }
}
