import 'package:app_movie/common/common.dart';
import 'package:app_movie/common/style/color.dart';
import 'package:flutter/material.dart';

class CallRetry extends StatelessWidget {
  const CallRetry({Key key, this.message, this.voidCallback, this.hideAppbar = true})
      : super(key: key);

  final String message;
  final VoidCallback voidCallback;
  final bool hideAppbar;

  @override
  Widget build(BuildContext context) {
    //abv
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: hideAppbar ? AppBar(
        elevation: 0,
        backgroundColor: AppColor.white,
        leading: const BackButton(
          color: AppColor.black,
        ),
      ): null,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(child: Text(message)),
          const SizedBox(
            height: 4,
          ),
          TextButton(
              style: TextButton.styleFrom(primary: Colors.white),
              onPressed: () {
                Common.showLoading(context);
                voidCallback?.call();
              },
              child: const Text(
                'Retry',
                style: TextStyle(color: Colors.red, fontSize: 18),
              ))
        ],
      ),
    );
  }
}
