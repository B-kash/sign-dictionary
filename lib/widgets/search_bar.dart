import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final ValueChanged<String> onSearchChanged;

  SearchBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => onSearchChanged(searchController.text),
          ),
        ],
      ),
    );
  }
}
