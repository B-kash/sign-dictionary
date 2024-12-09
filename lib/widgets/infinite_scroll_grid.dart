import 'package:flutter/material.dart';

class InfiniteScrollGrid<T> extends StatefulWidget {
  final Future<List<T>> Function(int skip, int take) fetchMoreItems;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final void Function(T item)? onTap;
  final int crossAxisCount;

  const InfiniteScrollGrid({
    super.key,
    required this.fetchMoreItems,
    required this.itemBuilder,
    this.onTap,
    this.crossAxisCount = 4,
  });

  @override
  _InfiniteScrollGridState<T> createState() => _InfiniteScrollGridState<T>();
}

class _InfiniteScrollGridState<T> extends State<InfiniteScrollGrid<T>> {
  final ScrollController _scrollController = ScrollController();
  List<T> _items = [];
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _fetchInitialItems();

    // Listen for scroll events to detect end of the list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isFetching) {
        _fetchMoreItems();
      }
    });
  }

  Future<void> _fetchInitialItems() async {
    setState(() {
      _isFetching = true;
    });

    final items = await widget.fetchMoreItems(0, 10);
    setState(() {
      _items = items;
      _isFetching = false;
    });
  }

  Future<void> _fetchMoreItems() async {
    setState(() {
      _isFetching = true;
    });

    final newItems = await widget.fetchMoreItems(_items.length, 10);
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return GestureDetector(
              onTap: widget.onTap != null ? () => widget.onTap!(item) : null,
              child: widget.itemBuilder(context, item),
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
