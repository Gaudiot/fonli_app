part of '../fonli_server.dart';

final class WordTranslationExerciseQuestion {
  final String word;
  final String translation;

  WordTranslationExerciseQuestion({
    required this.word,
    required this.translation,
  });

  factory WordTranslationExerciseQuestion.fromJson(
    Map<String, dynamic> json,
  ) => WordTranslationExerciseQuestion(
    word: json['word'] as String,
    translation: json['translation'] as String,
  );
}

final class WordTranslationExercise {
  final List<WordTranslationExerciseQuestion> questions;

  WordTranslationExercise({required this.questions});

  factory WordTranslationExercise.fromJson(Map<String, dynamic> json) =>
      WordTranslationExercise(
        questions: (json['questions'] as List<dynamic>)
            .map(
              (e) => WordTranslationExerciseQuestion.fromJson(
                e as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
}

final class Conjugation {
  final String person;
  final String number;
  final String conjugation;

  Conjugation({
    required this.person,
    required this.number,
    required this.conjugation,
  });

  factory Conjugation.fromJson(Map<String, dynamic> json) => Conjugation(
    person: json['person'] as String,
    number: json['number'] as String,
    conjugation: json['conjugation'] as String,
  );
}

final class WordConjugationExercise {
  final String word;
  final String tense;
  final List<Conjugation> conjugations;

  WordConjugationExercise({
    required this.word,
    required this.tense,
    required this.conjugations,
  });

  factory WordConjugationExercise.fromJson(Map<String, dynamic> json) =>
      WordConjugationExercise(
        word: json['word'] as String,
        tense: json['tense'] as String,
        conjugations: (json['conjugations'] as List<dynamic>)
            .map((e) => Conjugation.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

final class GenerateStoryResponse {
  final String story;

  GenerateStoryResponse({required this.story});

  factory GenerateStoryResponse.fromJson(Map<String, dynamic> json) =>
      GenerateStoryResponse(story: json['story'] as String);
}

final class EvaluateStoryTranslationRequest {
  final String story;
  final String userTranslation;

  EvaluateStoryTranslationRequest({
    required this.story,
    required this.userTranslation,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
    'story': story,
    'userTranslation': userTranslation,
  };
}

final class EvaluateStoryTranslationResponse {
  final int score;
  final List<String> errors;
  final String correctTranslation;

  EvaluateStoryTranslationResponse({
    required this.score,
    required this.errors,
    required this.correctTranslation,
  });

  factory EvaluateStoryTranslationResponse.fromJson(
    Map<String, dynamic> json,
  ) => EvaluateStoryTranslationResponse(
    score: (json['score'] as num).toInt(),
    errors: (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
    correctTranslation: json['correct_translation'] as String,
  );
}
