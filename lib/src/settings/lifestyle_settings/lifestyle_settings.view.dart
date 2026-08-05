import 'package:flutter/material.dart';
import 'package:fonli_app/core/components/snackbar/snackbar.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';
import 'package:fonli_app/src/settings/lifestyle_settings/lifestyle_settings.viewcontroller.dart';

class UserSettingsView extends StatefulWidget {
  const UserSettingsView({super.key});

  @override
  State<UserSettingsView> createState() => _UserSettingsViewState();
}

class _UserSettingsViewState extends State<UserSettingsView> {
  static const int _maxLifestyleLength = 500;

  final UserSettingsViewController viewController =
      UserSettingsViewController();
  final TextEditingController _lifestyleController = TextEditingController();
  bool _syncedInitialLifestyle = false;

  @override
  void initState() {
    super.initState();
    viewController.viewModel.addListener(_onViewModelChanged);
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await viewController.load();
    if (!mounted) return;
    if (viewController.viewModel.hasError) {
      snackbarMessenger.showError(context, 'Could not load lifestyle.');
    }
  }

  void _onViewModelChanged() {
    final vm = viewController.viewModel;
    if (vm.initialLoading || _syncedInitialLifestyle) return;
    _lifestyleController.text = vm.lifestyleText;
    _syncedInitialLifestyle = true;
  }

  Future<void> _onSave() async {
    final ok = await viewController.save(_lifestyleController.text);
    if (!mounted) return;
    if (ok) {
      snackbarMessenger.showSuccess(context, 'Lifestyle saved.');
    } else {
      snackbarMessenger.showError(context, 'Could not save lifestyle.');
    }
  }

  @override
  void dispose() {
    viewController.viewModel.removeListener(_onViewModelChanged);
    _lifestyleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: FColors.black),
          onPressed: () => NavigationManager.pop(context),
        ),
        title: Text(
          AppLocalizations.of(context).user_settings,
          style: TextStyle(color: FColors.black),
        ),
      ),
      body: Container(
        color: FColors.primary,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: ListenableBuilder(
            listenable: viewController.viewModel,
            builder: (context, _) {
              final vm = viewController.viewModel;

              if (vm.initialLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            AppLocalizations.of(context).lifestyle_header,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: FColors.black,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            AppLocalizations.of(context).lifestyle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _lifestyleController,
                            maxLines: 5,
                            maxLength: _maxLifestyleLength,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: FColors.primaryLighter,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: vm.saving ? null : _onSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: FColors.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: vm.saving
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: FColors.black,
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context).common__save,
                                    style: TextStyle(color: FColors.black),
                                  ),
                          ),
                        ],
                      ),
                    ),
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
