import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ItemRating extends StatelessWidget {
  final VoidCallback onAddRatingPressed;
  final VoidCallback onRatingPressed;

  const ItemRating({Key key, this.onAddRatingPressed, this.onRatingPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              '9.4',
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: AppFontWeight.medium,
                  fontSize: AppFontSize.medium),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              'Metascore',
              style: TextStyle(
                  color: AppColor.white,
                  fontWeight: AppFontWeight.normal,
                  fontSize: AppFontSize.label),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => onRatingPressed?.call(),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Icon(
                Icons.star_purple500_outlined,
                color: Colors.redAccent,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '8.1/10',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: AppFontWeight.medium,
                    fontSize: AppFontSize.medium),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                '189 Reviews',
                style: TextStyle(
                    color: AppColor.white,
                    fontWeight: AppFontWeight.normal,
                    fontSize: AppFontSize.label),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => onAddRatingPressed?.call(),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Icon(Icons.star_border_rounded),
              const SizedBox(
                height: 2,
              ),
              Text(
                'Rate this',
                style: TextStyle(
                    color: AppColor.white,
                    fontWeight: AppFontWeight.normal,
                    fontSize: AppFontSize.label),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
