import 'package:flutter/material.dart';

class DisplayConnectInternet extends StatelessWidget {
  const DisplayConnectInternet({Key key, this.message, this.voidCallback, this.showAppBar = true})
      : super(key: key);

  final String message;
  final VoidCallback voidCallback;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar ? AppBar(
        leading: const BackButton(
          color: Colors.white,
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
