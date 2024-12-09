import 'package:flutter/material.dart';

import '../models/grid_item.model.dart';

class InfiniteScrollGrid extends StatefulWidget {
  final List<GridItem> items; // The list of items to display
  final Future<void> Function() fetchMoreItems; // Function to fetch more items

  const InfiniteScrollGrid({super.key, required this.items, required this.fetchMoreItems});

  @override
  _InfiniteScrollGridState createState() => _InfiniteScrollGridState();
}

class _InfiniteScrollGridState extends State<InfiniteScrollGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Detect when user scrolls to the bottom to load more items
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Trigger the function to fetch more items when scrolled to the bottom
        widget.fetchMoreItems();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Number of items per row
        crossAxisSpacing: 0, // Space between columns
        mainAxisSpacing: 0, // Space between rows
      ),
      itemCount: widget.items.length, // Total number of items
      itemBuilder: (context, index) {
        // Get the current item
        final item = widget.items[index];
        return Card(
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Conditionally display the logo if it's not null
              item.logo != null
                  ? Image.network(item.logo!, height: 50, width: 50) // Display logo if available
                  : SizedBox(height: 50, width: 50), // Placeholder if no logo
              SizedBox(height: 10),
              Text(item.name, style: TextStyle(fontSize: 16)), // Display name
            ],
          ),
        );
      },
    );
  }
}
