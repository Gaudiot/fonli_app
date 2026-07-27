import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/base_viewcontroller.dart';
import 'package:fonli_app/core/components/base_viewmodel.dart';

class FView<VM extends FViewModel, T extends FViewController<VM>>
    extends StatefulWidget {
  final T viewController;
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context, VM value) builder;

  const FView({
    super.key,
    required this.viewController,
    required this.builder,
    this.appBar,
  });

  @override
  State<FView<VM, T>> createState() => _FViewState<VM, T>();
}

class _FViewState<VM extends FViewModel, T extends FViewController<VM>>
    extends State<FView<VM, T>> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.viewController.onInit(context);
    });
  }

  @override
  void dispose() {
    widget.viewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: ValueListenableBuilder(
        valueListenable: widget.viewController,
        builder: (context, value, child) {
          return widget.builder(context, value);
        },
      ),
    );
  }
}

abstract class FViewBuilder {
  const FViewBuilder();

  Widget build();
}
