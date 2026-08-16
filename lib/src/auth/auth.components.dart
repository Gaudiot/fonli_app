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

class _LoginForm extends StatelessWidget {
  final VoidCallback onSignUpTap;
  final VoidCallback onSubmit;
  final bool isLoading;
  final TextEditingController emailOrUsernameController;
  final TextEditingController passwordController;

  const _LoginForm({
    required this.onSignUpTap,
    required this.onSubmit,
    required this.isLoading,
    required this.emailOrUsernameController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return _AuthCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LoginFormHeader(onSignUpTap: onSignUpTap, isLoading: isLoading),
          const SizedBox(height: 24),
          FTextInput(
            label: AppLocalizations.of(context).email_or_username,
            controller: emailOrUsernameController,
          ),
          const SizedBox(height: 16),
          FTextInput(
            label: AppLocalizations.of(context).password,
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 48),
          FButton(
            isLoading: isLoading,
            text: AppLocalizations.of(context).login,
            onPressed: onSubmit,
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
        Text(
          AppLocalizations.of(context).login,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text.rich(
          TextSpan(
            text: "${AppLocalizations.of(context).no_account} ",
            children: [
              TextSpan(
                text: AppLocalizations.of(context).signup,
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

class _SignUpForm extends StatelessWidget {
  final VoidCallback onLogInTap;
  final VoidCallback onSubmit;
  final bool isLoading;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _SignUpForm({
    required this.onLogInTap,
    required this.onSubmit,
    required this.isLoading,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return _AuthCardShell(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SignUpFormHeader(onLogInTap: onLogInTap, isLoading: isLoading),
          const SizedBox(height: 24),
          FTextInput(
            label: AppLocalizations.of(context).username,
            controller: usernameController,
          ),
          const SizedBox(height: 16),
          FTextInput(
            label: AppLocalizations.of(context).email,
            controller: emailController,
          ),
          const SizedBox(height: 16),
          FTextInput(
            label: AppLocalizations.of(context).password,
            controller: passwordController,
            obscureText: true,
          ),
          const SizedBox(height: 48),
          FButton(
            isLoading: isLoading,
            text: AppLocalizations.of(context).signup,
            onPressed: onSubmit,
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
        Text(
          AppLocalizations.of(context).signup,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text.rich(
          TextSpan(
            text: "${AppLocalizations.of(context).have_account} ",
            children: [
              TextSpan(
                text: AppLocalizations.of(context).login,
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
