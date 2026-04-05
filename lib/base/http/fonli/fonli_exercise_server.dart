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
      final exercise = WordTranslationExercise.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(exercise);
    } catch (e) {
      return Result.error(
        _fonliExerciseExceptionFromCatch(
          e,
          'Failed to load word translation exercise. Try again later.',
        ),
      );
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
      final exercise = WordTranslationExercise.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(exercise);
    } catch (e) {
      return Result.error(
        _fonliExerciseExceptionFromCatch(
          e,
          'Failed to load word translation exercise. Try again later.',
        ),
      );
    }
  }

  static Future<Result<WordConjugationExercise, Exception>>
  getWordConjugationExercise(String targetLanguage) async {
    final dio = await _fonliDio();
    try {
      final response = await dio.get(
        '$baseUrl/exercises/word-conjugation?fl=$targetLanguage',
      );
      final exercise = WordConjugationExercise.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(exercise);
    } catch (e) {
      return Result.error(
        _fonliExerciseExceptionFromCatch(
          e,
          'Failed to load word conjugation exercise. Try again later.',
        ),
      );
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
      final story = GenerateStoryResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(story);
    } catch (e) {
      return Result.error(
        _fonliExerciseExceptionFromCatch(
          e,
          'Failed to generate story. Try again later.',
        ),
      );
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
      final evaluation = EvaluateStoryTranslationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      return Result.ok(evaluation);
    } catch (e) {
      return Result.error(
        _fonliExerciseExceptionFromCatch(
          e,
          'Failed to evaluate translation. Try again later.',
        ),
      );
    }
  }
}

Exception _fonliExerciseExceptionFromCatch(Object e, String fallbackMessage) {
  if (e is DioException && e.response != null) {
    final response = e.response!;
    return Exception(response.data['error']);
  }
  return Exception(fallbackMessage);
}
