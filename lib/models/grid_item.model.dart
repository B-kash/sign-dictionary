import 'package:sign_dictionary/models/localized.model.dart';

class GridItem {
  final String? logo; // URL or path to the logo image
  final Localized name; // Name of the item

  GridItem({this.logo, required this.name});
}
