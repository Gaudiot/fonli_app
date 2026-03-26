import 'package:dio/dio.dart';
import 'package:fonli_app/core/types/exercises.type.dart';
import 'package:fonli_app/core/types/response.type.dart';

class FonliServer {
  static const String baseUrl = "http://localhost:8000";

  static Future<Result<WordTranslationExercise, Exception>>
  getWordTranslationNativeToForeignExercise(
    String nativeLanguage,
    String targetLanguage,
  ) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/word-translation/native-to-foreign?nl=$nativeLanguage&fl=$targetLanguage',
    );

    if (response.statusCode != 200) {
      return Result.error(Exception("Failed to get word translation exercise"));
    }

    final WordTranslationExercise exercise = WordTranslationExercise.fromJson(
      response.data,
    );

    return Result.ok(exercise);
  }

  static Future<Result<WordTranslationExercise, Exception>>
  getWordTranslationForeignToNativeExercise(
    String nativeLanguage,
    String targetLanguage,
  ) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/word-translation/foreign-to-native?nl=$nativeLanguage&fl=$targetLanguage',
    );

    if (response.statusCode != 200) {
      return Result.error(
        Exception("Failed to submit word translation exercise"),
      );
    }

    final WordTranslationExercise exercise = WordTranslationExercise.fromJson(
      response.data,
    );

    return Result.ok(exercise);
  }

  static Future<Result<WordConjugationExercise, Exception>>
  getWordConjugationExercise(String targetLanguage) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/word-conjugation?fl=$targetLanguage',
    );

    if (response.statusCode != 200) {
      return Result.error(Exception("Failed to get word conjugation exercise"));
    }

    final WordConjugationExercise exercise = WordConjugationExercise.fromJson(
      response.data,
    );

    return Result.ok(exercise);
  }

  static Future<Result<GenerateStoryResponse, Exception>> generateStory(
    String nativeLanguage,
    String targetLanguage,
  ) async {
    Dio dio = Dio();
    final response = await dio.get(
      '$baseUrl/history-translation/generate?nl=$nativeLanguage&fl=$targetLanguage',
    );

    if (response.statusCode != 200) {
      return Result.error(Exception("Failed to generate story"));
    }

    final GenerateStoryResponse story = GenerateStoryResponse.fromJson(
      response.data,
    );

    return Result.ok(story);
  }

  static Future<Result<EvaluateStoryTranslationResponse, Exception>>
  evaluateStoryTranslation(
    EvaluateStoryTranslationRequest request,
    String nativeLanguage,
    String targetLanguage,
  ) async {
    Dio dio = Dio();
    final response = await dio.post(
      '$baseUrl/history-translation/evaluate?nl=$nativeLanguage&fl=$targetLanguage',
      data: request.toJson(),
    );

    if (response.statusCode != 200) {
      return Result.error(Exception("Failed to evaluate story translation"));
    }

    final EvaluateStoryTranslationResponse evaluation =
        EvaluateStoryTranslationResponse.fromJson(response.data);

    return Result.ok(evaluation);
  }
}
