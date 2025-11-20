import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryDark = Color(0xFF141A33);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Store  - UTS MOBPRO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: primaryDark,
        primaryColor: primaryDark,
        brightness: Brightness.dark,
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.white,
          background: Color(0xFF141A33),
          surface: Color(0xFF1A1A2F),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF141A33),
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xFF1A1A2F),
          indicatorColor: Colors.transparent,
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.white),
          ),
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xFF1A1A2F)),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
