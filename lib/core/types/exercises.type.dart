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

@JsonSerializable(createToJson: false)
class Conjugation {
  final String person;
  final String number;
  final String conjugation;

  Conjugation({required this.person, required this.number, required this.conjugation});

  factory Conjugation.fromJson(Map<String, dynamic> json) => _$ConjugationFromJson(json);
}

@JsonSerializable(createToJson: false)
class WordConjugationExercise {
  final String word;
  final String tense;
  final List<Conjugation> conjugations;

  WordConjugationExercise({required this.word, required this.tense, required this.conjugations});

  factory WordConjugationExercise.fromJson(Map<String, dynamic> json) => _$WordConjugationExerciseFromJson(json);
}