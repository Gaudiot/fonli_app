import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';

class FonliListTile extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const FonliListTile({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: FColors.primaryDarkest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onPressed,
    );
  }
}
