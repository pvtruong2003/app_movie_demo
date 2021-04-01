import 'package:app_movie/screens/profile_detail/profile_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePic extends StatelessWidget {
  final VoidCallback onPressed;
  final String url;

  const ProfilePic({
    Key key, this.onPressed, this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width:  120,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: url != null ? NetworkImage(url) : AssetImage('assets/images/user.png',),
            ),
            Positioned(
              right: 4,
              bottom: 0,
              child: SizedBox(
              height: 28,
              width: 28,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                  primary: Color(0xFFF5F6F9),
                  onPrimary: Color(0xFFF5F6F9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50.0)))
                ),
                onPressed: () => onPressed.call(),
                child: Icon(Icons.edit, size: 16, color: Colors.grey,),
                ),
              )
            ),
        ],
      ),
    );
  }
}