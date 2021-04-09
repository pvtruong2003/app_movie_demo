import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemSeeAll extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ItemSeeAll({Key key, this.title, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: AppFontSize.medium,
                fontWeight: AppFontWeight.medium,
                color: AppColor.white)),
        InkWell(
          onTap: () => onPressed?.call(),
          child: Text('SEE ALL',
              style: TextStyle(
                  fontSize: AppFontSize.text,
                  fontWeight: AppFontWeight.normal,
                  color: AppColor.white)),
        ),
      ],
    );
  }
}
