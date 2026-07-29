import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';

class FButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool isLoading;
  final bool isEnabled;

  const FButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = FColors.secondary,
    this.isLoading = false,
    this.isEnabled = true,
  });

  Color get _textColor => isEnabled ? FColors.black : FColors.disabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? _LoadingContent()
              : Text(text, style: TextStyle(color: _textColor)),
        ),
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 2.5,
      ),
    );
  }
}
