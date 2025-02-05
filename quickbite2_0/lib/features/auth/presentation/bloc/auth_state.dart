part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.initial,
    this.email = '',
    this.password = '',
  });

  final AuthStatus status;
  final String email;
  final String password;

  AuthState copyWith({
    AuthStatus? status,
    String? email,
    String? password,
  }) {
    return AuthState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, email, password];
}
