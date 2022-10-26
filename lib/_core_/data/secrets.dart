import 'package:flutter_dotenv/flutter_dotenv.dart';

class Secrets {
  static Future<void> init() async {
    await dotenv.load();
  }

  static String baseUrl = dotenv.maybeGet(SecretKeys.baseUrl) ?? '';
  static String apiKey = dotenv.maybeGet(SecretKeys.apiKey) ?? "";
}

class SecretKeys {
  static const String baseUrl = 'BASE_URL';
  static const String apiKey = 'API_KEY';
}
