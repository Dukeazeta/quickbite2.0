// Main entry point for QuickBite 2.0
// A minimal, fast, and vibrant food delivery application
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbite2_0/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:quickbite2_0/features/auth/domain/repositories/auth_repository.dart';
import 'package:quickbite2_0/features/auth/presentation/screens/login_screen.dart';
import 'package:quickbite2_0/features/dishes/presentation/screens/home_screen.dart';
import 'package:quickbite2_0/features/location/data/repositories/location_repository_impl.dart';
import 'package:quickbite2_0/features/location/domain/repositories/location_repository.dart';
import 'package:quickbite2_0/features/location/presentation/bloc/location_bloc.dart';

void main() {
  runApp(const QuickBiteApp());
}

class QuickBiteApp extends StatelessWidget {
  const QuickBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
        RepositoryProvider<LocationRepository>(
          create: (context) => LocationRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final bloc = LocationBloc(
                locationRepository: context.read<LocationRepository>(),
              );
              // Load last selected location when app starts
              bloc.add(LoadLastLocationEvent());
              return bloc;
            },
          ),
        ],
        child: MaterialApp(
          title: 'QuickBite 2.0',
          debugShowCheckedModeBanner: false, // Remove debug banner for clean UI
          theme: ThemeData(
            // Using Material 3 for modern, minimal design
            useMaterial3: true,
            fontFamily: 'SpaceGrotesk',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFE32F45),
              brightness: Brightness.dark,
            ),
            scaffoldBackgroundColor: const Color(0xFF1A1A1A),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            textTheme: const TextTheme(
              headlineLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              headlineMedium: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              titleLarge: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
              bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            cardTheme: CardTheme(
              color: const Color(0xFF2A2A2A),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color(0xFF2A2A2A),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(color: Colors.white54),
            ),
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
          },
        ),
      ),
    );
  }
}
