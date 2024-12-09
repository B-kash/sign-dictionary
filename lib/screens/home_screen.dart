import 'package:flutter/material.dart';
import 'package:sign_dictionary/screens/category_screen.dart';
import 'package:sign_dictionary/services/category_fetcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: CategoryScreen());
  }
}
