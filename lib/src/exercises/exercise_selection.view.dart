import 'package:flutter/material.dart';

class ExerciseSelectionView extends StatelessWidget {
  const ExerciseSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Text('Select an exercise:', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
        const SizedBox(height: 16),
        _ExerciseCard(title: 'Native to Foreign', onTap: () {}),
        _ExerciseCard(title: 'Foreign to Native', onTap: () {}),
        _ExerciseCard(title: 'Word Conjugation', onTap: () {}),
        _ExerciseCard(title: 'Story Translation', onTap: () {}),
      ],
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ExerciseCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(title),
        ),
      ),
    );
  }
}