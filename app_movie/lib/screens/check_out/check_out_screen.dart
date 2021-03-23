import 'package:app_movie/app_bar.dart';
import 'package:app_movie/app_container.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/common/widgets/item_booking.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/model/payment.dart';
import 'package:app_movie/screens/check_out/widgets/item_payment.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  final MovieDetail movie;

  const CheckOutScreen({Key key, this.movie}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  MovieDetail movieDetail;
  List<Payment> payments;
  @override
  void initState() {
    movieDetail = widget.movie;
    payments = [
      Payment(label: 'Credit Card', asset: 'assets/images/ic_visa.png'),
      Payment(label: 'Master Card', asset: 'assets/images/ic_master_card.png'),
      Payment(label: 'PayPal', asset: 'assets/images/ic_pay_pal.png'),
      Payment(label: 'Apple Pay', asset: 'assets/images/ic_apple_pay.png'),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StringBuffer genres = StringBuffer();
    movieDetail.genres.forEach((element) {
      genres.write(element.name);
      if (element.name != movieDetail.genres.last.name) {
        genres.write(', ');
      }
    });
    return AppContainer(
        appBar:
            customAppBar(leading: true, title: 'Check out', centerTitle: true),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: 120,
                  margin: const EdgeInsets.only(right: 12.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'http://image.tmdb.org/t/p/w500${movieDetail.posterPath}'))),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        movieDetail.title,
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: AppFontSize.medium,
                          fontWeight: AppFontWeight.medium,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        genres.toString(),
                        style: TextStyle(
                          color: AppColor.grayA6,
                          fontSize: AppFontSize.text,
                          fontWeight: AppFontWeight.normal,
                        ),
                      ),
                      TextButton.icon(
                          style: TextButton.styleFrom(
                              primary: AppColor.white,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 0)),
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_on_rounded,
                            color: Colors.black54,
                          ),
                          label: Text(
                            'Lotte Cinema',
                            style: TextStyle(color: Colors.black54),
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
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
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Payment Method ',
              style: TextStyle(
                color: AppColor.black,
                fontSize: AppFontSize.medium,
                fontWeight: AppFontWeight.semiBold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
          Container(
            height: 208,
            child: ListView.builder(
                itemCount: payments.length,
                itemBuilder: (ctx, index) {
                  Payment payment = payments[index];
                  return ItemPayment(
                   payment: payment,
                    onTap: () {

                    },
                  );
                }),
          )
        ],
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, MainScreen.routerName, (route) => false);
          },
          child: Text(
            'Pay - 55',
            style: TextStyle(
                color: AppColor.white,
                fontSize: AppFontSize.medium,
                fontWeight: AppFontWeight.medium),
          ),
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              padding: EdgeInsets.all(12.0),
              onPrimary: Colors.white,
              primary: Colors.pinkAccent),
        ),
      ),
    );
  }
}
