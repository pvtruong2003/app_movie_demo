import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppContainer extends StatefulWidget {

  const AppContainer(
      {Key key,
        @required this.child,
        this.appBar,
        this.bottomNavigationBar,
        this.hidePadding = false,
        this.enableSafeAreaOnTop = true,
        this.enableSafeAreaOnBottom = true,
        this.containerBackgroundColor = Colors.white,
        this.contentBackgroundColor = Colors.white,
        this.isResizeToAvoidBottomInset = true,
        this.isStatusBar = true,
        this.bottomSheet,
        this.drawer,
        this.paddingTop = 20.0,
        this.paddingLeft = 16.0,
        this.paddingRight = 16.0,
        this.paddingBottom = 20.0})
      : super(key: key);

  final PreferredSizeWidget appBar;
  final Widget bottomNavigationBar;
  final Widget child;
  final bool hidePadding;
  final bool enableSafeAreaOnTop;
  final bool isStatusBar;
  final bool enableSafeAreaOnBottom;
  final Color containerBackgroundColor;
  final Color contentBackgroundColor;
  final bool isResizeToAvoidBottomInset;
  final Widget bottomSheet;
  final Widget drawer;
  final double paddingTop, paddingLeft, paddingRight, paddingBottom;

  @override
  _AppContainerState createState() => _AppContainerState();
}

class _AppContainerState extends State<AppContainer> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _InheritedAppContainer(
      state: this,
      child: widget.isStatusBar
          ? AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark),
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: widget.containerBackgroundColor,
                appBar: widget.appBar,
                resizeToAvoidBottomInset: widget.isResizeToAvoidBottomInset,
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SafeArea(
                    top: widget.enableSafeAreaOnTop,
                    bottom: widget.enableSafeAreaOnBottom,
                    child: Container(
                      color: widget.contentBackgroundColor,
                      padding: widget.hidePadding
                          ? EdgeInsets.zero
                          : EdgeInsets.only(
                              top: widget.paddingTop,
                              left: widget.paddingLeft,
                              right: widget.paddingRight,
                              bottom: widget.paddingBottom),
                      child: widget.child,
                    ),
                  ),
                ),
                bottomNavigationBar: widget.bottomNavigationBar,
                bottomSheet: widget.bottomSheet,
                drawer: widget.drawer,
              ),
            )
          : Scaffold(
              key: scaffoldKey,
              backgroundColor: widget.containerBackgroundColor,
              appBar: widget.appBar,
              resizeToAvoidBottomInset: widget.isResizeToAvoidBottomInset,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SafeArea(
                  top: widget.enableSafeAreaOnTop,
                  bottom: widget.enableSafeAreaOnBottom,
                  child: Container(
                    color: widget.contentBackgroundColor,
                    padding: widget.hidePadding
                        ? EdgeInsets.zero
                        : EdgeInsets.only(
                            top: widget.paddingTop,
                            left: widget.paddingLeft,
                            right: widget.paddingRight,
                            bottom: widget.paddingBottom),
                    child: widget.child,
                  ),
                ),
              ),
              bottomNavigationBar: widget.bottomNavigationBar,
              bottomSheet: widget.bottomSheet,
              drawer: widget.drawer,
            ),
    );
  }
}

class _InheritedAppContainer extends InheritedWidget {
  const _InheritedAppContainer({
    Key key,
    @required this.state,
    @required Widget child,
  }) : super(key: key, child: child);

  final _AppContainerState state;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
