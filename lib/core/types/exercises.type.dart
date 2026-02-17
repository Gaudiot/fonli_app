import 'package:json_annotation/json_annotation.dart';

part 'exercises.type.g.dart';

@JsonSerializable(createToJson: false)
class WordTranslationExerciseQuestion {
  final String word;
  final String translation;

  WordTranslationExerciseQuestion({required this.word, required this.translation});

  factory WordTranslationExerciseQuestion.fromJson(Map<String, dynamic> json) => _$WordTranslationExerciseQuestionFromJson(json);
}

@JsonSerializable(createToJson: false)
class WordTranslationExercise {
  final List<WordTranslationExerciseQuestion> questions;

  WordTranslationExercise({required this.questions});

  factory WordTranslationExercise.fromJson(Map<String, dynamic> json) => _$WordTranslationExerciseFromJson(json);
}