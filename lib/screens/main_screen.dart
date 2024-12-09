import 'package:flutter/material.dart';
import '../widgets/search_bar.dart' as search;
import '../widgets/navigation_bar.dart' as nav;


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens to display based on the selected tab
  final List<Widget> _screens = [
    Center(child: Text('Home Screen')),
    Center(child: Text('Search Screen')),
    Center(child: Text('Settings Screen')),
    Center(child: Text('Profile Screen')),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My App')),
      body: Column(
        children: [
          search.SearchBar(),
          Expanded(child: _screens[_selectedIndex]), // Dynamic screen
        ],
      ),
      bottomNavigationBar: nav.NavigationBar(onTabSelected: _onTabSelected, currentIndex: _selectedIndex),
    );
  }
}
