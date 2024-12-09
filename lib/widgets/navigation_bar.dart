import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final ValueChanged<int> onTabSelected;

  NavigationBar({required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabSelected,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Social',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.social_distance),
          label: 'Sponsors',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'You',
        ),
      ],
    );
  }
}
