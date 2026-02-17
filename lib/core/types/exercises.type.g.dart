// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises.type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WordTranslationExerciseQuestion _$WordTranslationExerciseQuestionFromJson(
  Map<String, dynamic> json,
) => WordTranslationExerciseQuestion(
  word: json['word'] as String,
  translation: json['translation'] as String,
);

WordTranslationExercise _$WordTranslationExerciseFromJson(
  Map<String, dynamic> json,
) => WordTranslationExercise(
  questions: (json['questions'] as List<dynamic>)
      .map(
        (e) =>
            WordTranslationExerciseQuestion.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);
