import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class GridItemBuilder<T> extends StatelessWidget {

  const GridItemBuilder({Key key, this.items, this.itemBuilder}) : super(key: key);

  final List<T> items;
  final ItemWidgetBuilder<T> itemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext ctx, int index) {
        return itemBuilder(ctx, items[index]);
      },
    );
  }
}
