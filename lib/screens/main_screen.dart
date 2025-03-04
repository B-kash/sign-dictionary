import 'package:flutter/material.dart';
import 'package:sign_dictionary/screens/profile_screen.dart';
import 'package:sign_dictionary/screens/social_screen.dart';
import 'package:sign_dictionary/screens/sponsor_screen.dart';
import 'package:sign_dictionary/services/navigator_service.dart';
import '../widgets/search_bar.dart' as search;
import '../widgets/navigation_bar.dart' as nav;
import './home_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.onThemeToggle});

  final VoidCallback onThemeToggle;


  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static BuildContext? mainContext;
  Widget _currentBody = const HomeScreen();
  String _searchQuery = "";

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    NavigationService.registerSetBody(updateBody);
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchQuery = '';
      }
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void updateBody(Widget newBody) {
    setState(() {
      _currentBody = newBody;
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    SocialScreen(),
    SponsorScreen(),
    ProfileScreen(),
  ];

  void _onTabSelected(int index) {
    updateBody(_screens[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? search.SearchBar(
                onSearchChanged: _onSearchChanged,
              )
            : Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.cancel : Icons.search),
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: _currentBody,
      bottomNavigationBar: nav.NavigationBar(onTabSelected: _onTabSelected),
    );
  }
}
