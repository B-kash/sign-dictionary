import 'package:flutter/material.dart';
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/screens/word_list_screen.dart';
import 'package:sign_dictionary/services/navigator_service.dart';
import 'package:sign_dictionary/widgets/infinite_scroll_grid.dart';
import 'package:sign_dictionary/services/category_fetcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryFetcherService _categoryFetcherService =
      CategoryFetcherService();
  CategoryScreen({super.key});

  Future<List<GridItem>> _fetchCategories(int skip, int take) {
    return _categoryFetcherService.fetchCategoriesFromAssets(skip, take);
  }

  void _navigateToWords(BuildContext context, GridItem category) {
    NavigationService.navigateTo(
      WordListScreen(
        category: category.name[Localizations.localeOf(context).languageCode],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.categories)),
      body: InfiniteScrollGrid<GridItem>(
        fetchMoreItems: _fetchCategories,
        onTap: (item) => _navigateToWords(context, item),
        itemBuilder: (context, item) {
          return Card(
              elevation: 5,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
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
              ));
        },
      ),
    );
  }
}
