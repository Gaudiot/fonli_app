import 'package:dio/dio.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';
import 'package:fonli_app/core/types/exercises.type.dart';
import 'package:fonli_app/core/types/response.type.dart';

part 'fonli_dio.dart';

part 'fonli_user_server.dart';
part 'models/fonli_user_server.models.dart';

part 'fonli_auth_server.dart';
part 'models/fonli_auth_server.models.dart';

const String baseUrl = "http://localhost:8000";

class FonliServer {
  static Future<Result<WordTranslationExercise, Exception>>
  getWordTranslationNativeToForeignExercise(
    String nativeLanguage,
    String targetLanguage,
  ) async {
    final dio = await _fonliDio();
    final response = await dio.get(
      '$baseUrl/exercises/word-translation/native-to-foreign?nl=$nativeLanguage&fl=$targetLanguage',
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
    final dio = await _fonliDio();
    final response = await dio.get(
      '$baseUrl/exercises/word-translation/foreign-to-native?nl=$nativeLanguage&fl=$targetLanguage',
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
    final dio = await _fonliDio();
    final response = await dio.get(
      '$baseUrl/exercises/word-conjugation?fl=$targetLanguage',
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
    final dio = await _fonliDio();
    final response = await dio.get(
      '$baseUrl/exercises/story-translation/generate?nl=$nativeLanguage&fl=$targetLanguage',
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
    final dio = await _fonliDio();
    final response = await dio.post(
      '$baseUrl/exercises/story-translation/evaluate?nl=$nativeLanguage&fl=$targetLanguage',
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
