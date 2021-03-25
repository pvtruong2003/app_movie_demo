import 'package:app_movie/app_container.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/screens/completed/item_order.dart';
import 'package:app_movie/screens/completed/ticket_widget.dart';
import 'package:app_movie/screens/main/main_screen.dart';
import 'package:flutter/material.dart';

class CompletedScreen extends StatelessWidget {
  static const String routerName = 'completed';
  final String movie;

  const CompletedScreen({Key key, this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height * 0.4;
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, MainScreen.routerName);
        return false;
      },
      child: AppContainer(
          hidePadding: true,
          containerBackgroundColor: Colors.pink,
          contentBackgroundColor: Colors.pink,
          appBar: AppBar(
            leading: BackButton(onPressed: () {
               Navigator.pushNamedAndRemoveUntil(context, MainScreen.routerName, (route) => false);
            },),
            backgroundColor: Colors.pink,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColor.white),
            title: Text(
              'Ticket',
              style: TextStyle(
                  color: AppColor.white,
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: AppFontSize.large),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                  child: FlutterTicketWidget(
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    isCornerRounded: true,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text('Movie: $movie', style: TextStyle(
                          color: Colors.pink,
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppFontSize.medium)),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ItemOrder(
                                    label: 'Date',
                                    text: '26.03',
                                  ),
                                  ItemOrder(
                                    label: 'Time',
                                    text: '2h30',
                                  ),
                                  ItemOrder(
                                    label: 'Cinema',
                                    text: 'Lotte',
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ItemOrder(
                                    label: 'Seats',
                                    text: 'A5, A6',
                                  ),
                                  ItemOrder(
                                    label: 'Row',
                                    text: '5',
                                  ),
                                  ItemOrder(
                                    label: 'Order',
                                    text: '1355431',
                                  ),
                                ],
                              )
                            ],
                          ),
                          Expanded(child: Container()),

                          Image.network('https://hlf.vn/wp-content/uploads/2020/02/barcode-tt-Universalcode.png', height: 70, width: double.infinity, fit: BoxFit.fitWidth,)

                      ],),
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: size,
                  child: Container(
                    margin: EdgeInsets.only(left: 40, right: 40),
                    color: Colors.black26,
                    height: 1,
                    width: double.infinity,
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  height: 150,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Name\n',
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: AppFontSize.text,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'Michael Brann\n',
                                      style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: AppFontSize.text,
                                          fontWeight: AppFontWeight.medium))
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Price\n',
                                style: TextStyle(
                                  color: Colors.black26,
                                  fontSize: AppFontSize.text,
                                ),
                                children: [
                                  TextSpan(
                                      text: '47,50',
                                      style: TextStyle(
                                          color: Colors.pink,
                                          fontSize: AppFontSize.text,
                                          fontWeight: AppFontWeight.medium))
                                ]),
                          )
                        ],
                      ),
                      Image.network(
                          'https://user-images.githubusercontent.com/12584257/67494848-e3542700-f6b4-11e9-90ac-2992fdfc7310.png')
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
