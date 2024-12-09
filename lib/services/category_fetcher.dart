import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/models/localized.model.dart';

class CategoryFetcherService {
  String? jsonString; // Nullable type to allow initialization later
  List<dynamic>? jsonResponse; // Nullable to allow initialization later
Future<List<GridItem>> fetchCategoriesFromAssets(int skip, int take) async {
  if (jsonString == null || jsonString!.isEmpty) {
    try {
      jsonString = await rootBundle.loadString('assets/jsons/categories.json');
    } catch (e) {
      print('Error loading JSON file: $e');
      return [];
    }
  }

  if (jsonResponse == null || jsonResponse!.isEmpty) {
    try {
      jsonResponse = json.decode(jsonString!) as List<dynamic>;
    } catch (e) {
      print('Error parsing JSON file: $e');
      return [];
    }
  }

  try {
    List<GridItem> categories = jsonResponse!.map((jsonItem) {
      Map<String, String> localizedNames = {};
      if (jsonItem['name'] is Map) {
        for (var locale in (jsonItem['name'] as Map).keys) {
          localizedNames[locale] = jsonItem['name'][locale] ?? '';
        }
      }

      return GridItem(
        logo: (jsonItem['logo']?.isEmpty ?? true) ? null : jsonItem['logo'],
        name: Localized(localizedNames),
      );
    }).toList();

    return categories.skip(skip).take(take).toList();
  } catch (e) {
    print('Error processing categories: $e');
    return [];
  }
}

}
