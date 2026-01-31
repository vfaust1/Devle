import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/word_service.dart';
import 'services/theme_service.dart';

final themeService = ThemeService(); 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await WordService.loadDictionary();
  await themeService.loadTheme();

  runApp(const DevleApp());
}

class DevleApp extends StatelessWidget {
  const DevleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeService,
      builder: (context, child) {
        return MaterialApp(
          title: 'Devle',
          debugShowCheckedModeBanner: false,
          
          themeMode: themeService.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white
            ),
          ),
          
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.black, 
            useMaterial3: true,
             appBarTheme: const AppBarTheme(
              backgroundColor: Colors.grey,
            ),
          ),
          
          home: const HomeScreen(),
        );
      },
    );
  }
}