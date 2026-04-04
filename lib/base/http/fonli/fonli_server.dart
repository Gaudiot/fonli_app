import 'package:dio/dio.dart';
import 'package:fonli_app/core/storage/secure_storage.interface.dart';
import 'package:fonli_app/core/types/response.type.dart';

part 'fonli_dio.dart';

part 'fonli_user_server.dart';
part 'models/fonli_user_server.models.dart';

part 'fonli_auth_server.dart';
part 'models/fonli_auth_server.models.dart';

part 'models/fonli_exercise_server.models.dart';
part 'fonli_exercise_server.dart';

const String baseUrl = "http://localhost:8000";
