import 'package:flutter/material.dart';
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/services/words_fetcher.dart';
import 'package:sign_dictionary/widgets/infinite_scroll_grid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.word_list_title)),
      body: InfiniteScrollGrid<GridItem>(
        fetchMoreItems: _fetchWords,
        itemBuilder: (context, item) {
          return Card(
            elevation: 5,
            child: 
            MouseRegion (
              cursor: SystemMouseCursors.click,
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
            )
          );
        },
      ),
    );
  }
}
