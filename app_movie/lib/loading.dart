import 'package:app_movie/common/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Material(
        color: Colors.black.withOpacity(0.1),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.all(16.0),
                child: CupertinoActivityIndicator()),
          ),
        ),
      ),
    );
  }
}
