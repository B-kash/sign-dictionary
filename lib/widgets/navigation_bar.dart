import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final ValueChanged<int> onTabSelected;
  int currentIndex;

  onTabPressed(int index) {
    currentIndex = index;
    onTabSelected(index);
  }

  NavigationBar({super.key, required this.onTabSelected, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabPressed,
      currentIndex: currentIndex,
      backgroundColor: Colors.blue[50], // Set background color of the nav bar
      selectedItemColor: Colors.blue[300], // Color of the selected item
      unselectedItemColor: Colors.grey, // Color of the unselected items
      elevation: 8.0, // Optional: add shadow for a more prominent effect
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
