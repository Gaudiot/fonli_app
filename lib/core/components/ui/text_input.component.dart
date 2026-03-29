import 'package:flutter/material.dart';

class FTextInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool obscureText;

  const FTextInput({
    super.key,
    required this.label,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.black),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
