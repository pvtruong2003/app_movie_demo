
import 'package:flutter/material.dart';

AppBar customAppBar({bool automaticallyImplyLeading = false, String title, bool centerTitle = false, List<Widget> actions }) {
  return AppBar(
     automaticallyImplyLeading: false,
     title: Text(title ?? '', style:  TextStyle(color: Colors.white),),
     centerTitle: centerTitle,
     actions: actions,
  );
}

