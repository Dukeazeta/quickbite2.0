// Abstract class defining the contract for authentication operations
abstract class AuthRepository {
  // Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password);

  // Sign up with email and password
  Future<void> signUpWithEmailAndPassword(String email, String password);

  // Sign out the current user
  Future<void> signOut();

  // Check if user is authenticated
  Future<bool> isAuthenticated();
}
