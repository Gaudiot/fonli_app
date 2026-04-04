part of 'fonli_server.dart';

class FonliExerciseServer {
  FonliExerciseServer._();

  static Future<Result<WordTranslationExercise, Exception>>
  getWordTranslationNativeToForeignExercise(
    String nativeLanguage,
    String targetLanguage,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.get(
        '$baseUrl/exercises/word-translation/native-to-foreign?nl=$nativeLanguage&fl=$targetLanguage',
      );
      if (response.statusCode != 200) {
        return Result.error(
          Exception('Failed to get word translation exercise'),
        );
      }
      final exercise = WordTranslationExercise.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(exercise);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  static Future<Result<WordTranslationExercise, Exception>>
  getWordTranslationForeignToNativeExercise(
    String nativeLanguage,
    String targetLanguage,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.get(
        '$baseUrl/exercises/word-translation/foreign-to-native?nl=$nativeLanguage&fl=$targetLanguage',
      );
      if (response.statusCode != 200) {
        return Result.error(
          Exception('Failed to get word translation exercise'),
        );
      }
      final exercise = WordTranslationExercise.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(exercise);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  static Future<Result<WordConjugationExercise, Exception>>
  getWordConjugationExercise(String targetLanguage) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.get(
        '$baseUrl/exercises/word-conjugation?fl=$targetLanguage',
      );
      if (response.statusCode != 200) {
        return Result.error(
          Exception('Failed to get word conjugation exercise'),
        );
      }
      final exercise = WordConjugationExercise.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(exercise);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  static Future<Result<GenerateStoryResponse, Exception>> generateStory(
    String nativeLanguage,
    String targetLanguage,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.get(
        '$baseUrl/exercises/story-translation/generate?nl=$nativeLanguage&fl=$targetLanguage',
      );
      if (response.statusCode != 200) {
        return Result.error(Exception('Failed to generate story'));
      }
      final story = GenerateStoryResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(story);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  static Future<Result<EvaluateStoryTranslationResponse, Exception>>
  evaluateStoryTranslation(
    EvaluateStoryTranslationRequest request,
    String nativeLanguage,
    String targetLanguage,
  ) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.post(
        '$baseUrl/exercises/story-translation/evaluate?nl=$nativeLanguage&fl=$targetLanguage',
        data: request.toJson(),
      );
      if (response.statusCode != 200) {
        return Result.error(
          Exception('Failed to evaluate story translation'),
        );
      }
      final evaluation = EvaluateStoryTranslationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(evaluation);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
