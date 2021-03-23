import 'package:flutter/material.dart';

class IcButtonLogin extends StatelessWidget {
  const IcButtonLogin({Key key, this.icon, this.onPressed}) : super(key: key);

  final String icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Image.asset(
          icon,
          color: Colors.black,
          filterQuality: FilterQuality.high,
        ),
        onPressed: () => onPressed?.call());
  }
}
