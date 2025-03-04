import 'package:flutter/material.dart';
import 'package:sign_dictionary/screens/main_screen.dart';
import 'package:sign_dictionary/theme.dart';
import 'screens/loading_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void _toggleTheme() async {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', _isDarkMode);
  }

  void _loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTheme();
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
