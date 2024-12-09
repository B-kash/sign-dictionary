// grid_item_service.dart
import '../models/grid_item.model.dart';

class CategoryFetcherService {

  

  Future<List<GridItem>> fetchMoreItems(int currentItemCount) async {
    // Simulate a delay to mimic network request
    await Future.delayed(Duration(seconds: 2));

    // Generate mock data for demonstration
    return List.generate(
      100,
      (index) => GridItem(name: 'Item ${currentItemCount + index + 1}'),
    );
  }
}
