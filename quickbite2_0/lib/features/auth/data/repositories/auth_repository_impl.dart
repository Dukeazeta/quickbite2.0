import 'package:quickbite2_0/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  static const _adminEmail = 'admin';
  static const _adminPassword = 'admin';

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    
    if (email == _adminEmail && password == _adminPassword) {
      return;
    }
    
    throw Exception('Invalid credentials');
  }

  @override
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    // TODO: Implement actual sign up logic
    throw UnimplementedError('Sign up not implemented yet');
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    // TODO: Implement actual sign out logic
  }

  @override
  Future<bool> isAuthenticated() async {
    // TODO: Implement actual authentication check
    return false;
  }
}
