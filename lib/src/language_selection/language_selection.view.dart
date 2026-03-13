import 'package:flutter/material.dart';
import 'package:fonli_app/base/contexts/language.context.dart';
import 'package:fonli_app/core/navigation/navigation.dart';
import 'package:fonli_app/core/storage/local_storage.interface.dart';

class _LanguageModel {
  final String name;
  final String code;

  _LanguageModel({required this.name, required this.code});
}

final List<_LanguageModel> _languages = [
  _LanguageModel(name: "English", code: "US"),
  _LanguageModel(name: "Portuguese", code: "BR"),
  _LanguageModel(name: "French", code: "FR"),
  _LanguageModel(name: "Italian", code: "IT"),
];

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
    return Scaffold(
      body: SafeArea(
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
                        const Text("Native Language"),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
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
                        const Text("Target Language"),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.separated(
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
            ElevatedButton(onPressed: onSavePressed, child: const Text("Save")),
          ],
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
          color: isSelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(language.name),
      ),
    );
  }
}
