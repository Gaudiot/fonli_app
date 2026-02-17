import 'package:flutter/material.dart';

class WordTranslationCard extends StatefulWidget {
  final String word;
  final String translation;
  final bool isAnswerHidden;
  final bool? isCorrect;

  const WordTranslationCard({
    super.key,
    required this.word,
    required this.translation,
    required this.isAnswerHidden,
    this.isCorrect,
  });

  @override
  State<WordTranslationCard> createState() => _WordTranslationCardState();
}

class _WordTranslationCardState extends State<WordTranslationCard> {
  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    if (!widget.isAnswerHidden && widget.isCorrect != null) {
      borderColor = widget.isCorrect! ? Colors.green : Colors.red;
    }

    return Card(
      color: Colors.grey[300],
      shape: borderColor != null
          ? RoundedRectangleBorder(
              side: BorderSide(color: borderColor, width: 3),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TextPlace(label: 'Word:', text: widget.word),
              if (!widget.isAnswerHidden) ...[
                const Divider(color: Colors.black),
                _TextPlace(label: 'Translation:', text: widget.translation),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _TextPlace extends StatelessWidget {
  final String label;
  final String text;

  const _TextPlace({required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
