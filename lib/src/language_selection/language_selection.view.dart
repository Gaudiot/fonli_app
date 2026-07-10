import 'package:flutter/material.dart';
import 'package:fonli_app/base/notifiers/language.notifier.dart';
import 'package:fonli_app/core/design/colors.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';
import 'package:fonli_app/l10n/output/app_localizations.dart';

class _LanguageModel {
  final String name;
  final String code;

  _LanguageModel({required this.name, required this.code});
}

class LanguageSelectionView extends StatefulWidget {
  const LanguageSelectionView({super.key});

  @override
  State<LanguageSelectionView> createState() => _LanguageSelectionViewState();
}

class _LanguageSelectionViewState extends State<LanguageSelectionView> {
  String selectedNativeLanguage = "US";
  String selectedTargetLanguage = "BR";
  final LanguageNotifier _languageNotifier = LanguageNotifier();

  void initLanguages() async {
    selectedNativeLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.nativeLanguage,
      "US",
    );
    selectedTargetLanguage = await localStorage.getStringWithDefault(
      LocalStorageKeys.targetLanguage,
      "BR",
    );

    setState(() {});
  }

  @override
  void initState() {
    initLanguages();
    super.initState();
  }

  void onNativeLanguageTap(String languageCode) {
    setState(() {
      selectedNativeLanguage = languageCode;
    });
  }

  void onTargetLanguageTap(String languageCode) {
    setState(() {
      selectedTargetLanguage = languageCode;
    });
  }

  void onSavePressed() async {
    if (selectedNativeLanguage == selectedTargetLanguage) {
      return;
    }
    _languageNotifier.nativeLanguage = selectedNativeLanguage;
    _languageNotifier.targetLanguage = selectedTargetLanguage;

    if (context.mounted) {
      NavigationManager.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<_LanguageModel> _languages = [
      _LanguageModel(
        name: AppLocalizations.of(context)!.lang__english,
        code: "US",
      ),
      _LanguageModel(
        name: AppLocalizations.of(context)!.lang__portuguese,
        code: "BR",
      ),
      _LanguageModel(
        name: AppLocalizations.of(context)!.lang__french,
        code: "FR",
      ),
      _LanguageModel(
        name: AppLocalizations.of(context)!.lang__italian,
        code: "IT",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: FColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: FColors.black),
          onPressed: () {
            NavigationManager.pop(context);
          },
        ),
      ),
      body: Container(
        color: FColors.primary,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(AppLocalizations.of(context)!.native_lang),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  _LanguageSelectionItem(
                                    language: _languages[index],
                                    isSelected:
                                        selectedNativeLanguage ==
                                        _languages[index].code,
                                    onTap: () => onNativeLanguageTap(
                                      _languages[index].code,
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemCount: _languages.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(AppLocalizations.of(context)!.foreign_lang),
                          const SizedBox(height: 8),
                          Expanded(
                            child: ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  _LanguageSelectionItem(
                                    language: _languages[index],
                                    isSelected:
                                        selectedTargetLanguage ==
                                        _languages[index].code,
                                    onTap: () => onTargetLanguageTap(
                                      _languages[index].code,
                                    ),
                                  ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 16),
                              itemCount: _languages.length,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _SaveSelectionButton(onPressed: onSavePressed),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSelectionItem extends StatelessWidget {
  final _LanguageModel language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageSelectionItem({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? FColors.secondary : FColors.primaryLightest,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(language.name),
      ),
    );
  }
}

class _SaveSelectionButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveSelectionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: FColors.secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        AppLocalizations.of(context)!.save,
        style: TextStyle(color: FColors.black),
      ),
    );
  }
}
