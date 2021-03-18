import 'package:app_movie/model/movie_detail.dart';
import 'package:flutter/material.dart';

class ItemCompany extends StatelessWidget {
  const ItemCompany({Key key, this.company}) : super(key: key);

  final ProductionCompany company;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Center(
          child: company.logoPath != null
              ? Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                        'http://image.tmdb.org/t/p/w500${company.logoPath}'))),
          )
              : Text(
            company.name,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
