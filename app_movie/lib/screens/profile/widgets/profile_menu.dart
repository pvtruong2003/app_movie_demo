import 'package:app_movie/common/style/color.dart';
import 'package:app_movie/common/style/fonts.dart';
import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        color: Color(0xFFF5F6F9),
        onPressed: () {
          press();
        },
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColor.black.withOpacity(0.5),),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: AppColor.black.withOpacity(0.8,), fontSize: AppFontSize.label, fontWeight: AppFontWeight.normal),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20, color: AppColor.black.withOpacity(0.5),)
          ],
        ),
      ),
    );
  }
}
