import 'package:flutter/material.dart';
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/services/category_fetcher.dart';



class InfiniteScrollGrid extends StatefulWidget {
  final CategoryFetcherService categoryFetcher; // Service to fetch items

  const InfiniteScrollGrid({super.key, required this.categoryFetcher});

  @override
  _InfiniteScrollGridState createState() => _InfiniteScrollGridState();
}

class _InfiniteScrollGridState extends State<InfiniteScrollGrid> {
  final ScrollController _scrollController = ScrollController();
  List<GridItem> _items = []; // List to store fetched items
  bool _isFetching = false; // Track if fetch is in progress

  @override
  void initState() {
    super.initState();
    _fetchInitialItems();

    // Listen for scroll events to detect end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          !_isFetching) {
        _fetchMoreItems();
      }
    });
  }

  Future<void> _fetchInitialItems() async {
    setState(() {
      _isFetching = true;
    });

    final items = await widget.categoryFetcher.fetchMoreItems(_items.length);
    setState(() {
      _items = items;
      _isFetching = false;
    });
  }

  Future<void> _fetchMoreItems() async {
    setState(() {
      _isFetching = true;
    });

    final newItems = await widget.categoryFetcher.fetchMoreItems(_items.length);
    setState(() {
      _items.addAll(newItems);
      _isFetching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  item.logo != null
                      ? Image.network(item.logo!, height: 50, width: 50)
                      : SizedBox(height: 50, width: 50),
                  const SizedBox(height: 10),
                  Text(item.name, style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          },
        ),
        if (_isFetching)
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}