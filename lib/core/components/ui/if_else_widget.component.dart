import 'package:flutter/material.dart';

class IfElseWidget extends StatelessWidget {
  final Widget ifChild;
  final Widget elseChild;
  final bool condition;

  const IfElseWidget({
    super.key,
    required this.ifChild,
    required this.elseChild,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? ifChild : elseChild;
  }
}
