import 'package:desk/dashboard_screen.dart';
import 'package:desk/home_screen.dart';
import 'package:desk/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskRoom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(title: "TaskRoom"),
      routes: {
        '/home' : (context) => HomeScreen()
      }
    );
  }
}

