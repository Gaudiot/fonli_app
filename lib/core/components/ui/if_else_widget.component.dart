import 'package:flutter/material.dart';

class IfElseWidget extends StatelessWidget {
  final bool condition;
  final WidgetBuilder ifChild;
  final WidgetBuilder elseChild;

  const IfElseWidget({
    super.key,
    required this.condition,
    required this.ifChild,
    required this.elseChild,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? ifChild(context) : elseChild(context);
  }
}
