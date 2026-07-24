import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/ui/button.component.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/onboarding/onboarding.viewcontroller.dart';
import 'package:fonli_app/src/onboarding/steps/lifestyle/onboarding_lifestyle.viewcontroller.dart';

class OnboardingLifestyleView extends StatefulWidget {
  static const int _maxLifestyleLength = 500;
  final StreamSink<OnboardingStepStatus> eventStream;

  const OnboardingLifestyleView({super.key, required this.eventStream});

  @override
  State<OnboardingLifestyleView> createState() =>
      _OnboardingLifestyleViewState();
}

class _OnboardingLifestyleViewState extends State<OnboardingLifestyleView> {
  late final OnboardingLifestyleViewController viewController;
  final TextEditingController _lifestyleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewController = OnboardingLifestyleViewController(
      eventStream: widget.eventStream,
    );
    _lifestyleController.addListener(_onLifestyleControllerChanged);
  }

  void _onLifestyleControllerChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _lifestyleController.removeListener(_onLifestyleControllerChanged);
    _lifestyleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: FColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: ListenableBuilder(
            listenable: viewController.viewModel,
            builder: (context, child) {
              final vm = viewController.viewModel;

              return Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.onboarding__lifestyle_title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: _lifestyleController,
                    maxLines: 5,
                    maxLength: OnboardingLifestyleView._maxLifestyleLength,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: FColors.primaryLighter,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(
                      context,
                    )!.onboarding__lifestyle_description,
                  ),
                  Spacer(),
                  FButton(
                    text: AppLocalizations.of(context)!.common__next,
                    color: FColors.secondary,
                    onPressed: () =>
                        viewController.onNextPressed(_lifestyleController.text),
                    isEnabled: _lifestyleController.text.trim().isNotEmpty,
                    isLoading: vm.isLoading,
                  ),
                  TextButton(
                    onPressed: viewController.onSkipPressed,
                    child: Text(AppLocalizations.of(context)!.common__skip),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
