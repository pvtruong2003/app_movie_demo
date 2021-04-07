import 'package:app_movie/app_container.dart';
import 'package:app_movie/bloc/booking_bloc.dart';
import 'package:app_movie/bloc/movie_detail_bloc.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/book.dart';
import 'package:app_movie/model/movie_detail.dart';
import 'package:app_movie/screens/home/booking/item_date.dart';
import 'package:app_movie/screens/home/widgets/navigator_screen.dart';
import 'package:app_movie/uitils/string_uitils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingMovie extends StatefulWidget {
  final MovieDetailBloc movieDetailBloc;

  const BookingMovie({Key key, this.movieDetailBloc}) : super(key: key);

  @override
  _BookingMovieState createState() => _BookingMovieState();
}

class _BookingMovieState extends State<BookingMovie> {
  MovieDetail movieDetail;

  bool isScroll = true;
  BookingBloc bookingBloc;

  @override
  void initState() {
    movieDetail = widget.movieDetailBloc.getMovie();
    bookingBloc = BookingBloc();
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
    return AppContainer(
        contentBackgroundColor: AppColor.black,
        hidePadding: true,
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: AppColor.black,
                  centerTitle: true,
                  iconTheme: IconThemeData(color: AppColor.white),
                  title: Text(
                    'Booking',
                    style: TextStyle(
                        color: AppColor.white,
                        fontWeight: AppFontWeight.semiBold,
                        fontSize: AppFontSize.medium),
                  ),
                  expandedHeight: 250,
                  snap: true,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.only(left: 16.0, bottom: 20.0),
                    title: Text(
                      movieDetail.title,
                      style: TextStyle(
                          color: AppColor.white,
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppFontSize.medium),
                    ),
                    background: Image.network(
                      StringUtils.urlImage(movieDetail.posterPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isScroll = false;
                          });
                        },
                        icon: Icon(Icons.settings))
                  ],
                ),
                SliverToBoxAdapter(
                  child: _buildGenres(),
                ),
                SliverToBoxAdapter(
                  child: _buildListDate(),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 400,
                    child: StreamBuilder<List<Times>>(
                        stream: bookingBloc.times,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 16),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemBuilder: (ctx, index) {
                                Times item = snapshot.data[index];
                                return InkWell(
                                  onTap: () {
                                     bookingBloc.updateSelectTime(itemTime: item, index: index);
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                              color: item.isSelected  ? AppColor.white : AppColor.grayBorder,
                                              width: 1)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.time,
                                            style: _buildTextStyle(item),
                                          ),
                                          Text(
                                            item.price.toString(),
                                            style: _buildTextStyle(item),
                                          )
                                        ],
                                      )),
                                );
                              },
                              itemCount: snapshot.data.length,
                            );
                          }
                          return Container();
                        }),
                  ),
                ),
              ],
            ),
           _buildButtonBuyTicket(),
          ],
        ));

    // AppContainer(
    //     contentBackgroundColor: AppColor.black,
    //     hidePadding: true,
    //     child: Column(
    //       children: [
    //         SizedBox(
    //           height: MediaQuery.of(context).size.height * 0.4,
    //           width: MediaQuery.of(context).size.width,
    //           child: Stack(
    //             children: [
    //               Image.network(
    //                 StringUtils.urlImage(movieDetail.posterPath),
    //                 fit: BoxFit.cover,
    //                 width: MediaQuery.of(context).size.width,
    //               ),
    //               Icon(
    //                 Icons.arrow_back_rounded,
    //                 color: AppColor.white,
    //               ),
    //               Align(
    //                 alignment: Alignment.topCenter,
    //                 child: Text(
    //                   'Booking',
    //                   style: TextStyle(
    //                       color: AppColor.white,
    //                       fontWeight: AppFontWeight.semiBold,
    //                       fontSize: AppFontSize.medium),
    //                 ),
    //               ),
    //               Align(
    //                 alignment: Alignment.topRight,
    //                 child: IconButton(
    //                     onPressed: () {
    //                       setState(() {
    //                         isScroll = true;
    //                       });
    //                     },
    //                     icon: Icon(Icons.settings)),
    //               )
    //             ],
    //           ),
    //         ),
    //         _buildGenres(),
    //         _buildListDate(),
    //         Expanded(
    //             child: StreamBuilder<Book>(
    //                 stream: bookingBloc.book,
    //                 builder: (context, snapshot) {
    //                   return GridView.builder(
    //                       padding: EdgeInsets.only(
    //                           left: 16, right: 16, top: 16, bottom: 60),
    //                       itemCount: snapshot.data.times.length,
    //                       gridDelegate:
    //                       SliverGridDelegateWithFixedCrossAxisCount(
    //                           crossAxisCount: 2,
    //                           crossAxisSpacing: 12,
    //                           mainAxisSpacing: 12,
    //                           childAspectRatio: 2 / 1),
    //                       itemBuilder: (ctx, index) {
    //                         Times times = snapshot.data.times[index];
    //                         return Container(
    //                             alignment: Alignment.center,
    //                             decoration: BoxDecoration(
    //                                 borderRadius:
    //                                 BorderRadius.circular(8.0),
    //                                 border: Border.all(
    //                                     color: AppColor.grayBorder,
    //                                     width: 1)),
    //                             child: Column(
    //                               mainAxisAlignment:
    //                               MainAxisAlignment.center,
    //                               children: [
    //                                 Text(
    //                                   times.time,
    //                                   style: TextStyle(
    //                                       color: AppColor.white.withOpacity(
    //                                         0.7,
    //                                       ),
    //                                       fontWeight: AppFontWeight.normal,
    //                                       fontSize: AppFontSize.label),
    //                                 ),
    //                                 Text(
    //                                   times.price.toString(),
    //                                   style: TextStyle(
    //                                       color: AppColor.white.withOpacity(
    //                                         0.7,
    //                                       ),
    //                                       fontWeight: AppFontWeight.normal,
    //                                       fontSize: AppFontSize.text),
    //                                 )
    //                               ],
    //                             ));
    //                       });
    //                 })),
    //         Align(
    //           alignment: Alignment.bottomCenter,
    //           child: MaterialButton(
    //             color: Colors.pink,
    //             minWidth: MediaQuery.of(context).size.width,
    //             padding: EdgeInsets.all(14.0),
    //             materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //             //Remove space bottom
    //             onPressed: () {
    //               Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                       builder: (BuildContext ctx) => BookingMovie(
    //                         movieDetailBloc: movieDetailBloc,
    //                       )));
    //             },
    //             shape: RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.circular(0.0)),
    //             child: Text(
    //               'CHOOSE SEATS',
    //               style: TextStyle(
    //                   color: AppColor.white,
    //                   fontWeight: AppFontWeight.medium,
    //                   fontSize: AppFontSize.medium),
    //             ),
    //           ),
    //         )
    //       ],
    //     ))
  }

  Align _buildButtonBuyTicket() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: NavigatorScreen(
        textButton: 'CHOOSE SEATS',
        onPressed: () {

        },
      ),
    );
  }

  TextStyle _buildTextStyle(Times item) {
    return TextStyle(
        color: item.isSelected
            ? AppColor.white
            : AppColor.white.withOpacity(
                0.7,
              ),
        fontWeight:
            item.isSelected ? AppFontWeight.medium : AppFontWeight.normal,
        fontSize: item.isSelected ? AppFontSize.medium : AppFontSize.text);
  }

  _buildListDate() {
    return Container(
      color: AppColor.black,
      height: 60,
      alignment: Alignment.center,
      child: StreamBuilder<Book>(stream: bookingBloc.book, builder: (ctx, snapshots) {
            if (snapshots.hasData) {
              DateTime start =
                  new DateFormat("dd/MM/yyyy").parse(snapshots.data.start);
              DateTime end =
                  new DateFormat("dd/MM/yyyy").parse(snapshots.data.end);
              List<DateTime> dateTimes = calculateDaysInterval(start, end);
              if (snapshots.data.times.isNotEmpty) {
                return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: dateTimes.length,
                    itemBuilder: (ctx, index) {
                      return ItemDate(
                        dateTime: dateTimes[index],
                        onPressed: (String date) {
                           bookingBloc.updateTime(date: date);
                        },
                      );
                    });
              }
            }
            return Container();
          }),
    );
  }

    _buildGenres() {
    return Container();
    return SingleChildScrollView(
      child: Row(
        children: movieDetail.genres.map((e) {
          return Container(
            padding:
                const EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
            margin: EdgeInsets.only(left: 16, top: 24),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(4.0)),
            child: Text(
              e.name,
              style: const TextStyle(color: AppColor.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
