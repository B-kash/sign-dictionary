import 'package:flutter/material.dart';
import 'package:sign_dictionary/screens/profile_screen.dart';
import 'package:sign_dictionary/screens/social_screen.dart';
import 'package:sign_dictionary/screens/sponsor_screen.dart';
import '../widgets/search_bar.dart' as search;
import '../widgets/navigation_bar.dart' as nav;
import './home_screen.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens to display based on the selected tab
  final List<Widget> _screens = [
    HomeScreen(),
    SocialScreen(),
    SponsorScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NSL Dictionary')),
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
