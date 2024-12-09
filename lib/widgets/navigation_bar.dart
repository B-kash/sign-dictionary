import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavigationBar extends StatefulWidget {
  final ValueChanged<int> onTabSelected;

  const NavigationBar({super.key, required this.onTabSelected});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentIndex = 0;
  onTabPressed(int index) {
    currentIndex = index;
    widget.onTabSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTabPressed,
      currentIndex: currentIndex,
      backgroundColor: Colors.blue[50], // Set background color of the nav bar
      selectedItemColor: Colors.blue[300], // Color of the selected item
      unselectedItemColor: Colors.grey, // Color of the unselected items
      elevation: 8.0, // Optional: add shadow for a more prominent effect
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.group),
          label: AppLocalizations.of(context)!.social,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.social_distance),
          label: AppLocalizations.of(context)!.sponsors,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.account_circle),
          label: AppLocalizations.of(context)!.you,
        ),
      ],
    );
  }
}
