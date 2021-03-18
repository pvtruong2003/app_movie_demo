import 'package:flutter/material.dart';

class ItemRichText extends StatelessWidget {
  const ItemRichText({Key key, this.data, this.label}) : super(key: key);

  final String data;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: data,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            children: <TextSpan>[
          TextSpan(
              text: ' $label',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400))
        ]));
  }
}
