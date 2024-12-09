import 'package:flutter/material.dart';
import 'package:sign_dictionary/screens/main_screen.dart';
import 'package:sign_dictionary/screens/word_list_screen.dart';

class NavigationService {
  static late Function(Widget) _setBody;

  /// Registers the method to update the body of the main screen
  static void registerSetBody(Function(Widget) setBodyCallback) {
    _setBody = setBodyCallback;
  }

  /// Navigate to a specific screen based on the body widget and optional data
  static void navigateTo(Widget body) {
    if (_setBody == null) {
      print('No way to set body. Ensure registerSetBody is called during initialization.');
      return;
    }
    // Update the body with the provided widget and optional data
    _setBody(body);
  }
}