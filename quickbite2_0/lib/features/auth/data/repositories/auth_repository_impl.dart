import 'package:quickbite2_0/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const _adminEmail = 'admin';
  static const _adminPassword = 'admin';

  @override
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    
    if (email == _adminEmail && password == _adminPassword) {
      return;
    }
    
    throw Exception('Invalid credentials');
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }
}
