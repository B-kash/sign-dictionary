import 'package:flutter/material.dart';
import 'package:sign_dictionary/screens/main_screen.dart';
import 'package:sign_dictionary/theme.dart';
import 'screens/loading_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false; // Track the current theme

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: const [
        Locale('en'), // English
        Locale('np'), // Nepali
      ],
      theme: _isDarkMode ? AppThemes.darkTheme : AppThemes.lightTheme,
      home: FutureBuilder(
        future: _initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else {
            return MainScreen(onThemeToggle: _toggleTheme);
          }
        },
      ),
    );
  }

  Future<void> _initializeApp() async {
    await Future.delayed(const Duration(seconds: 3)); // Adjust delay as needed
  }
}

