import 'package:dio/dio.dart';
import 'package:fonli_app/core/types/exercises.type.dart';
import 'package:fonli_app/core/types/response.type.dart';

class FonliServer {
  static const String baseUrl = "http://localhost:8000";

  static Future<Result<WordTranslationExercise, Exception>> getWordTranslationExercise() async {
    Dio dio = Dio();
    final response = await dio.get('$baseUrl/word-translation/native-to-foreign');

    if (response.statusCode != 200) {
      return Result.error(Exception("Failed to get word translation exercise"));
    }

    final WordTranslationExercise exercise = WordTranslationExercise.fromJson(response.data);

    return Result.ok(exercise);
  }
}