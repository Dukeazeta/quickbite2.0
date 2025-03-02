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
            create: (context) => LocationBloc(
              locationRepository: context.read<LocationRepository>(),
            ),
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
              seedColor: Colors.orange,
              brightness: Brightness.light,
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
