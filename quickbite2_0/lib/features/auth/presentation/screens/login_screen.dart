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
            // Navigate to home screen
            Navigator.of(context).pushReplacementNamed('/home');
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Image with Overlay
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/sam-moghadam-VpOpy6QrDrs-unsplash.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const _EmailInput(),
                    const SizedBox(height: 12),
                    const _PasswordInput(),
                    const SizedBox(height: 20),
                    const _LoginButton(),
                  ],
                ),
              ),
            ],
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
      hintText: 'Email (admin)',
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
      hintText: 'Password (admin)',
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
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return CustomButton(
          text: state.status == AuthStatus.loading ? '' : 'Login',
          onPressed: state.status == AuthStatus.loading
              ? () {} 
              : () {
                  context.read<AuthBloc>().add(const SignInSubmitted());
                },
          icon: state.status == AuthStatus.loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : null,
        );
      },
    );
  }
}
