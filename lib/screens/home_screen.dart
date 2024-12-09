import 'package:flutter/material.dart';
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/widgets/infinite_scroll_grid.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GridItem> items = List.generate(
      100, (index) => GridItem(name: 'Item $index'),
      growable: true);
      // TODO: replace this with actual api call may be
  Future<void> fetchMoreItems() async {
    await Future.delayed(Duration(seconds: 2));
    var newItems = List.generate(
        100, (index) => GridItem(name: 'Item ${items.length + index + 1}')
        );
    setState(() {
      items.addAll(newItems);
    });
    print('Fetched more items');

  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
            InfiniteScrollGrid(items: items, fetchMoreItems: fetchMoreItems));
  }
}
