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

Conjugation _$ConjugationFromJson(Map<String, dynamic> json) => Conjugation(
  person: json['person'] as String,
  number: json['number'] as String,
  conjugation: json['conjugation'] as String,
);

WordConjugationExercise _$WordConjugationExerciseFromJson(
  Map<String, dynamic> json,
) => WordConjugationExercise(
  word: json['word'] as String,
  tense: json['tense'] as String,
  conjugations: (json['conjugations'] as List<dynamic>)
      .map((e) => Conjugation.fromJson(e as Map<String, dynamic>))
      .toList(),
);

GenerateStoryResponse _$GenerateStoryResponseFromJson(
  Map<String, dynamic> json,
) => GenerateStoryResponse(story: json['story'] as String);

Map<String, dynamic> _$EvaluateStoryTranslationRequestToJson(
  EvaluateStoryTranslationRequest instance,
) => <String, dynamic>{
  'story': instance.story,
  'userTranslation': instance.userTranslation,
};

EvaluateStoryTranslationResponse _$EvaluateStoryTranslationResponseFromJson(
  Map<String, dynamic> json,
) => EvaluateStoryTranslationResponse(
  score: (json['score'] as num).toInt(),
  errors: (json['errors'] as List<dynamic>).map((e) => e as String).toList(),
  correctTranslation: json['correct_translation'] as String,
);
