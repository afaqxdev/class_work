import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiApiService {
  final String _baseUrl =
      'https://api.gemini.com'; // Update with the correct endpoint

  Future<String> getNutritionInfo(String query) async {
    try {
      String result = '';

      await for (var value in Gemini.instance.promptStream(parts: [
        Part.text(
            "You name is  Nutri AI make sure the resopnse is shorter and to the point and if user ask you some thing irrelevant dont give asnwer insisted say them i dont know and also provider the soruce like from where you get this info make sure the title will be bold    $query"),
      ])) {
        result += value?.output ?? '';
      }

      return result.isNotEmpty ? result : "I don't know about that.";
    } catch (e) {
      return 'Error: $e';
    }
  }
}
