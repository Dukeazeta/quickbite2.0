// Main entry point for QuickBite 2.0
// A minimal, fast, and vibrant food delivery application
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbite2_0/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:quickbite2_0/features/auth/domain/repositories/auth_repository.dart';
import 'package:quickbite2_0/features/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(const QuickBiteApp());
}

class QuickBiteApp extends StatelessWidget {
  const QuickBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (context) => AuthRepositoryImpl(),
      child: MaterialApp(
        title: 'QuickBite 2.0',
        debugShowCheckedModeBanner: false, // Remove debug banner for clean UI
        theme: ThemeData(
          // Using Material 3 for modern, minimal design
          useMaterial3: true,
          fontFamily: 'SpaceGrotesk',
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
            brightness: Brightness.light,
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickBite'),
        centerTitle: true,
        elevation: 0, // Minimal design with no elevation
      ),
      body: const Center(
        child: Text('Welcome to QuickBite 2.0'),
      ),
    );
  }
}
