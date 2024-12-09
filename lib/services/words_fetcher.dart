import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:sign_dictionary/models/grid_item.model.dart';
import 'package:sign_dictionary/models/localized.model.dart';

class WordFetcherService {
  String? jsonString;
  List<dynamic>? jsonResponse;

  Future<List<GridItem>> fetchWordsByCategory(
      String category, int skip, int take) async {
    if (jsonString == null || jsonString!.isEmpty) {
      try {
        jsonString = await rootBundle.loadString('assets/jsons/words.json');
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
      List<GridItem> words = jsonResponse!.where((jsonItem) {
        if (jsonItem['categories'] is List) {
          return (jsonItem['categories'] as List).contains(category);
        }
        return false;
      }).map((jsonItem) {
        Map<String, String> localizedNames = {};
        if (jsonItem['name'] is Map) {
          for (var locale in (jsonItem['name'] as Map).keys) {
            localizedNames[locale] = jsonItem['name'][locale] ?? '';
          }
        }

        return GridItem(
          name: Localized(localizedNames),
        );
      }).toList();
      return words.skip(skip).take(take).toList();
    } catch (e) {
      print('Error processing categories: $e');
      return [];
    }
  }
}
