import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:fyp_with_gemini/api_key.dart';
import 'package:provider/provider.dart';

import 'chat_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ChatProvider(),
      child: NutritionChatBot(),
    ),
  );
  Gemini.init(apiKey: apiKey);
}

class NutritionChatBot extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  NutritionChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Nutrition Chatbot')),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatProvider.messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(chatProvider.messages[index]),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter your question',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      final query = _controller.text.trim();
                      if (query.isNotEmpty) {
                        chatProvider.sendQuery(query);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
