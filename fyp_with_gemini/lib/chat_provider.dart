import 'package:flutter/material.dart';
import 'package:fyp_with_gemini/gemin_class.dart';

class ChatProvider with ChangeNotifier {
  final GeminiApiService _apiService = GeminiApiService();
  final List<String> _messages = [];

  List<String> get messages => _messages;

  void addMessage(String message) {
    _messages.add(message);
    notifyListeners();
  }

  Future<void> sendQuery(String query) async {
    addMessage('You: $query');
    final response = await _apiService.getNutritionInfo(query);
    addMessage('Bot: $response');
  }
}
