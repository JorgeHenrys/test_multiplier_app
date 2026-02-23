import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_multiplier_app/src/core/core.dart';
import 'package:test_multiplier_app/src/features/chat/data/datasources/datasources.dart';
import 'package:uuid/uuid.dart';

class ChatRemoteDatasource implements ChatDatasource {
  final Dio _client;

  ChatRemoteDatasource({required Dio client}) : _client = client;

  @override
  Future<MessageModel> sendMessageStream({
    required List<MessageEntity> messages,
  }) async {
    try {
      final openaiKey = dotenv.env['OPENAI_API_KEY'];
      if (openaiKey != null && openaiKey.isEmpty) {
        throw Exception("OpenAI API Key não configurada");
      }

      final options = Options(
        headers: {
          "Authorization": "Bearer $openaiKey",
          "Content-Type": "application/json",
        },
      );

      final response = await _client.post(
        "https://api.openai.com/v1/chat/completions",
        options: options,
        data: {
          "model": "gpt-4o-mini",
          "messages": [
            {
              "role": "system",
              "content": "Você é LARA, uma IA divertida e muito bem humorada.",
            },
            ...messages.map(
              (m) => {
                "role": m.sender == SenderEnum.user ? "user" : "assistant",
                "content": m.content,
              },
            ),
          ],
        },
      );

      final content = response.data["choices"][0]["message"]["content"];

      return MessageModel(
        id: const Uuid().v1(),
        content: content,
        sender: SenderEnum.lara.name,
        createdAt: DateTime.now().toString(),
      );
    } on DioException catch (err) {
      throw ServerException(
        message: err.message ?? err.toString(),
        statusCode: err.response?.statusCode ?? 500,
      );
    } catch (err) {
      throw ServerException(message: err.toString());
    }
  }
}
