import 'package:app_movie/common/common.dart';
import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  const NavigatorButton({Key key, this.label, this.onPressed}) : super(key: key);

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
         FocusScope.of(context).requestFocus(FocusNode());
         onPressed?.call();
         Common.showLoading(context);
      },
      minWidth: double.infinity,
      padding: EdgeInsets.all(14.0),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      color: Colors.black,
      child:  Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
