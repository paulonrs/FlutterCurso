import 'package:flutter/material.dart';
import 'package:flutter_curso/ui/pages/login/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const customColorScheme = ColorScheme(
      primary: Color(0xFF7D19FF),
      primaryContainer: Color(0xFF3B0F3B),
      secondary: Color(0xFF1E081D),
      secondaryContainer: Color(0xFF808080),
      surface: Color.fromRGBO(0, 0, 0, 0),
      background: Color.fromARGB(255, 0, 0, 0),
      error: Color.fromARGB(255, 255, 125, 125),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onBackground: Colors.white,
      onError: Colors.white,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        colorScheme: customColorScheme,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF111111),
          labelStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: customColorScheme.primary, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: customColorScheme.primary, width: 2),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
