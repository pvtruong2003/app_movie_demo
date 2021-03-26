import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:app_movie/model/actor.dart';
import 'package:flutter/material.dart';

class ItemActor extends StatelessWidget {
  final Actor actor;

  const ItemActor({Key key, this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              actor.url,
              fit: BoxFit.cover,
              width: 140,
              height: 150,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            actor.name,
            style: TextStyle(
                color: AppColor.white,
                fontWeight: AppFontWeight.normal,
                fontSize: AppFontSize.medium),
          )
        ],
      ),
    );
  }
}
