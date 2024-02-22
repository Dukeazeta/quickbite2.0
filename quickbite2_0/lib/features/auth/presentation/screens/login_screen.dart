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
      backgroundColor: Colors.white,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Image
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sam-moghadam-VpOpy6QrDrs-unsplash.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Content Container with rounded top corners
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  transform: Matrix4.translationValues(0, -30, 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Let\'s Connect With Us!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        const _EmailInput(),
                        const SizedBox(height: 12),
                        const _PasswordInput(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
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
                        const SizedBox(height: 24),
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
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 30),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Color(0xFF87CF6A),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatefulWidget {
  const _EmailInput();

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'Email or Phone Number',
      keyboardType: TextInputType.emailAddress,
      controller: _emailController,
      onChanged: (email) {
        context.read<AuthBloc>().add(EmailChanged(email));
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput();

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hintText: 'Password',
      isPassword: true,
      controller: _passwordController,
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
