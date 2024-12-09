import 'package:flutter/material.dart';
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/services/words_fetcher.dart';
import 'package:sign_dictionary/widgets/infinite_scroll_grid.dart';

class WordListScreen extends StatelessWidget {
  final String category;
  final WordFetcherService _wordFetcherService = WordFetcherService();
  WordListScreen({super.key, required this.category});

  Future<List<GridItem>> _fetchWords(int skip, int take) {
    return _wordFetcherService.fetchWordsByCategory(category, skip, take);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: InfiniteScrollGrid<GridItem>(
        fetchMoreItems: _fetchWords,
        itemBuilder: (context, item) {
          return Card(
            elevation: 5,
            color: Colors.blue[100],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  item.name[Localizations.localeOf(context).languageCode],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
