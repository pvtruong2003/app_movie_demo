
import 'package:app_movie/common/style/color.dart';
import 'package:flutter/material.dart';

AppBar customAppBar({bool leading = false ,bool automaticallyImplyLeading = false, String title, bool centerTitle = false, List<Widget> actions }) {
  return AppBar(
      leading: leading ? BackButton(): null,
      elevation: 0,
      backgroundColor: Colors.white,
     automaticallyImplyLeading: false,
     title: Text(title ?? '', style:  TextStyle(color: AppColor.black),),
     centerTitle: centerTitle,
     actions: actions,
  );
}

