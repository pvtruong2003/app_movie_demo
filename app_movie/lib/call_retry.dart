import 'package:app_movie/common/style/color.dart';
import 'package:flutter/material.dart';

class CallRetry extends StatelessWidget {
  const CallRetry({Key key, this.message, this.voidCallback, this.showAppBar = true})
      : super(key: key);

  final String message;
  final VoidCallback voidCallback;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
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
