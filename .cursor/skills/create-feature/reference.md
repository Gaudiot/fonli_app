# Reference skeletons

Replace `FeatureName`, `feature_name`, and import paths with the real case.

## `feature_name.viewmodel.dart`

Only if the screen needs shared reactive state with the View.

```dart
import 'package:fonli_app/core/components/base_viewstate.dart';

final class FeatureNameViewModel extends BaseViewState {
  bool isInitialLoading = true;
  bool isButtonLoading = false;
  String lifestyleText = '';
  List<String> optionsList = [];
}
```

## `feature_name.viewcontroller.dart`

```dart
import 'package:fonli_app/src/<domain>/feature_name/feature_name.viewmodel.dart';

class FeatureNameViewController {
  final FeatureNameViewModel viewModel = FeatureNameViewModel();

  Future<void> load() async {
    viewModel.isInitialLoading = true;
    viewModel.notifyListeners();
    // final result = await SomeBaseService.fetch();
    // result.when(
    //   onOk: (data) { viewModel.lifestyleText = data.text; },
    //   onError: (_) { viewModel.hasError = true; },
    // );
    viewModel.isInitialLoading = false;
    viewModel.notifyListeners();
  }
}
```

If there is **no** ViewModel, the ViewController can be stateless functions — but then the View has no central `ListenableBuilder`; prefer a minimal ViewModel with clear flags (`isInitialLoading`, `hasError`, etc.) if the screen may grow.

## `feature_name.view.dart`

```dart
import 'package:flutter/material.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/src/<domain>/feature_name/feature_name.viewcontroller.dart';

class FeatureNameView extends StatefulWidget {
  const FeatureNameView({super.key});

  @override
  State<FeatureNameView> createState() => _FeatureNameViewState();
}

class _FeatureNameViewState extends State<FeatureNameView> {
  final FeatureNameViewController viewController = FeatureNameViewController();

  @override
  void initState() {
    super.initState();
    viewController.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: viewController.viewModel,
        builder: (context, _) {
          final vm = viewController.viewModel;
          if (vm.isInitialLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Placeholder(); // replace with real UI
        },
      ),
    );
  }
}
```

## Typical imports (adjust as needed)

- Design: `package:fonli_app/core/design/colors.dart`
- Navigation: `package:fonli_app/core/navigation/navigation.dart`
- HTTP entry points: `package:fonli_app/base/http/fonli/fonli_server.dart` (or specific services under `base/`)
