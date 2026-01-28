import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DevleApp());
}

class DevleApp extends StatelessWidget {
  const DevleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        useMaterial3: true,
        // colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
    );
  }
}