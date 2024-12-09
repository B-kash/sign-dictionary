import 'package:flutter/material.dart';
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/screens/word_list_screen.dart';

typedef FetchItemsCallback = Future<List<GridItem>> Function(
    int currentItemCount);

class InfiniteScrollGrid extends StatefulWidget {
  final FetchItemsCallback fetchMoreItems; // Function to fetch items

  const InfiniteScrollGrid({super.key, required this.fetchMoreItems});

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
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isFetching) {
        _fetchMoreItems();
      }
    });
  }

  Future<void> _fetchInitialItems() async {
    setState(() {
      _isFetching = true;
    });

    final items = await widget.fetchMoreItems(_items.length);
    setState(() {
      _items = items;
      _isFetching = false;
    });
  }

  Future<void> _fetchMoreItems() async {
    setState(() {
      _isFetching = true;
    });

    final newItems = await widget.fetchMoreItems(_items.length);
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
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WordListScreen(
                        category: item.name[
                            Localizations.localeOf(context).languageCode]),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                color: Colors.blue[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    item.logo != null
                        ? Image.network(item.logo!, height: 50, width: 50)
                        : const SizedBox(height: 50, width: 50),
                    const SizedBox(height: 10),
                    Text(
                      item.name[Localizations.localeOf(context).languageCode],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        if (_isFetching)
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
