import 'package:flutter/material.dart';
import 'package:sign_dictionary/services/category_fetcher.dart';
import 'package:sign_dictionary/widgets/infinite_scroll_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CategoryFetcherService _categoryFetcherService =
      CategoryFetcherService();

  @override
  Widget build(BuildContext context) {
    return Center(child: InfiniteScrollGrid(
      fetchMoreItems: (currentItemCount) {
        const int batchSize = 10; // Number of items to fetch per call
        return _categoryFetcherService.fetchCategoriesFromAssets(
            currentItemCount, batchSize);
      },
    ));
  }
}
