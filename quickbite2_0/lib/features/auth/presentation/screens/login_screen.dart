import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbite2_0/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:quickbite2_0/features/common/widgets/custom_button.dart';
import 'package:quickbite2_0/features/common/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Invalid credentials. Use admin/admin')),
              );
          } else if (state.status == AuthStatus.success) {
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                const _EmailInput(),
                const SizedBox(height: 12),
                const _PasswordInput(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const _LoginButton(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey[300])),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey[300])),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Sign up with Apple',
                  onPressed: () {},
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  icon: const Icon(Icons.apple, color: Colors.white),
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Sign up with Google',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  textColor: Colors.black87,
                  hasBorder: true,
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                    height: 20,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'Email or Phone Number',
      keyboardType: TextInputType.emailAddress,
      onChanged: (email) {
        context.read<AuthBloc>().add(EmailChanged(email));
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'Password',
      isPassword: true,
      onChanged: (password) {
        context.read<AuthBloc>().add(PasswordChanged(password));
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => 
        previous.status != current.status ||
        previous.email != current.email ||
        previous.password != current.password,
      builder: (context, state) {
        final bool isEnabled = state.email.isNotEmpty && state.password.isNotEmpty;
        return CustomButton(
          text: state.status == AuthStatus.loading ? '' : 'Login',
          onPressed: state.status == AuthStatus.loading || !isEnabled
              ? () {} 
              : () {
                  context.read<AuthBloc>().add(const SignInSubmitted());
                },
          backgroundColor: isEnabled ? const Color(0xFF87CF6A) : const Color(0xFFEBF7E7),
          textColor: isEnabled ? Colors.white : const Color(0xFF87CF6A),
          icon: state.status == AuthStatus.loading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: isEnabled ? Colors.white : const Color(0xFF87CF6A),
                  ),
                )
              : null,
        );
      },
    );
  }
}
