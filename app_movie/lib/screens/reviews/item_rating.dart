import 'package:app_movie/common/style/color.dart';
import 'package:flutter/material.dart';

class ItemRating extends StatelessWidget {
  final bool isRating;
  final VoidCallback onPressed;

  const ItemRating({Key key, this.isRating, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => onPressed.call(),
        icon: isRating
            ? Icon(
                Icons.star_purple500_outlined,
                color: Colors.yellow[600],
                size: 28,
              )
            : Icon(
                Icons.star_border_rounded,
                color: AppColor.grayA6,
              ));
  }
}
