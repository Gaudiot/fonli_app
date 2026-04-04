import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/components/ui/text_input.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/src/auth/auth.viewcontroller.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthViewController viewController = AuthViewController();

  @override
  void initState() {
    super.initState();
    viewController.viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    viewController.viewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    if (viewController.viewModel.isAuthenticated) {
      NavigationManager.replaceWith(
        context,
        NavigationRoutes.exerciseSelection,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [FColors.secondary, FColors.primary],
          ),
        ),
        child: Center(
          child: ListenableBuilder(
            listenable: viewController.viewModel,
            builder: (context, _) {
              final vm = viewController.viewModel;

              return vm.isLogin
                  ? _LoginForm(
                      onSignUpTap: viewController.toggleForm,
                      onSubmit: viewController.submitLogin,
                      isLoading: vm.isLoading,
                    )
                  : _SignUpForm(
                      onLogInTap: viewController.toggleForm,
                      onSubmit: viewController.submitSignUp,
                      isLoading: vm.isLoading,
                    );
            },
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final VoidCallback onSignUpTap;
  final void Function(String, String) onSubmit;
  final bool isLoading;

  const _LoginForm({
    required this.onSignUpTap,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final emailOrUsernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailOrUsernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          Column(
            mainAxisSize: .min,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text.rich(
                TextSpan(
                  text: "Don't have an account? ",
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      recognizer: widget.isLoading
                          ? null
                          : (TapGestureRecognizer()
                              ..onTap = widget.onSignUpTap),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          FTextInput(
            label: 'Email/Username',
            controller: emailOrUsernameController,
          ),
          SizedBox(height: 16),
          FTextInput(
            label: 'Password',
            controller: passwordController,
            obscureText: true,
          ),
          SizedBox(height: 48),
          FButton(
            isLoading: widget.isLoading,
            text: "Log In",
            onPressed: () => widget.onSubmit(
              emailOrUsernameController.text,
              passwordController.text,
            ),
            color: FColors.primaryDark,
          ),
        ],
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  final VoidCallback onLogInTap;
  final void Function(String, String, String) onSubmit;
  final bool isLoading;

  const _SignUpForm({
    required this.onLogInTap,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          Column(
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text.rich(
                TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Log In',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      recognizer: widget.isLoading
                          ? null
                          : (TapGestureRecognizer()..onTap = widget.onLogInTap),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          FTextInput(label: 'Username', controller: usernameController),
          SizedBox(height: 16),
          FTextInput(label: 'Email', controller: emailController),
          SizedBox(height: 16),
          FTextInput(
            label: 'Password',
            controller: passwordController,
            obscureText: true,
          ),
          SizedBox(height: 48),
          FButton(
            isLoading: widget.isLoading,
            text: "Sign Up",
            onPressed: () => widget.onSubmit(
              usernameController.text,
              emailController.text,
              passwordController.text,
            ),
            color: FColors.primaryDark,
          ),
        ],
      ),
    );
  }
}
