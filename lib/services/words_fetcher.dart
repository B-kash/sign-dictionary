import 'dart:convert';
import 'package:flutter/services.dart';

class WordService {
  static String? jsonString;
  static List<dynamic>? jsonResponse;

  static Future<List<Map<String, dynamic>>> fetchWordsByCategory(
      String category, int skip, int take) async {
    if (jsonString == null || jsonString!.isEmpty) {
      jsonString = await rootBundle.loadString('assets/jsons/words.json');
    }

    if (jsonResponse == null || jsonResponse!.isEmpty) {
      jsonResponse = json.decode(jsonString!) as List<dynamic>;
    }

    return jsonResponse!
        .where((word) => (word['categories'] as List).contains(category))
        .map((word) => word as Map<String, dynamic>)
        .skip(skip)
        .take(take)
        .toList();
  }
}
