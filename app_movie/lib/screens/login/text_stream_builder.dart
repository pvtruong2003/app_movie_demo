import 'package:flutter/material.dart';

typedef ItemWidgetBuilder = Widget Function(BuildContext context, String item);

class TextStreamBuilder extends StatelessWidget {
  const TextStreamBuilder({Key key, this.stream, this.builder})
      : super(key: key);

  final Stream<String> stream;
  final ItemWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: stream,
        builder: (BuildContext ctx, AsyncSnapshot<String> snap) => builder(ctx, snap.data));
  }
}
