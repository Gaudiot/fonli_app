import 'package:flutter/widgets.dart';
import 'package:fonli_app/core/components/base_viewmodel.dart';

class FViewController<T extends FViewModel> extends ValueNotifier<T> {
  FViewController({required T viewModel}) : super(viewModel);

  void onInit(BuildContext context) {}
}
