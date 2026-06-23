part of 'auth.view.dart';

//MARK: - Auth Card Shell

class _AuthCardShell extends StatelessWidget {
  final Widget child;

  const _AuthCardShell({required this.child});

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
      child: child,
    );
  }
}

//MARK: - Login Form

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
    return _AuthCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LoginFormHeader(
            onSignUpTap: widget.onSignUpTap,
            isLoading: widget.isLoading,
          ),
          const SizedBox(height: 24),
          FTextInput(
            label: 'Email/Username',
            controller: emailOrUsernameController,
          ),
          const SizedBox(height: 16),
          FTextInput(
            label: 'Password',
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 48),
          FButton(
            isLoading: widget.isLoading,
            text: 'Log In',
            onPressed: () => widget.onSubmit(
              emailOrUsernameController.text,
              passwordController.text,
            ),
            color: FColors.secondary,
          ),
        ],
      ),
    );
  }
}

class _LoginFormHeader extends StatelessWidget {
  final VoidCallback onSignUpTap;
  final bool isLoading;

  const _LoginFormHeader({required this.onSignUpTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
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
                style: const TextStyle(fontWeight: FontWeight.bold),
                recognizer: isLoading
                    ? null
                    : (TapGestureRecognizer()..onTap = onSignUpTap),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//MARK: - Register (Sign up)

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
    return _AuthCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SignUpFormHeader(
            onLogInTap: widget.onLogInTap,
            isLoading: widget.isLoading,
          ),
          const SizedBox(height: 24),
          FTextInput(label: 'Username', controller: usernameController),
          const SizedBox(height: 16),
          FTextInput(label: 'Email', controller: emailController),
          const SizedBox(height: 16),
          FTextInput(
            label: 'Password',
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 48),
          FButton(
            isLoading: widget.isLoading,
            text: 'Sign Up',
            onPressed: () => widget.onSubmit(
              usernameController.text,
              emailController.text,
              passwordController.text,
            ),
            color: FColors.secondary,
          ),
        ],
      ),
    );
  }
}

class _SignUpFormHeader extends StatelessWidget {
  final VoidCallback onLogInTap;
  final bool isLoading;

  const _SignUpFormHeader({required this.onLogInTap, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
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
                style: const TextStyle(fontWeight: FontWeight.bold),
                recognizer: isLoading
                    ? null
                    : (TapGestureRecognizer()..onTap = onLogInTap),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
