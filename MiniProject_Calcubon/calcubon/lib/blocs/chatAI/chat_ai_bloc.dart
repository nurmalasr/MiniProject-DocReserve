import 'package:bloc/bloc.dart';
import 'package:calcubon/blocs/chatAI/chat_ai_event.dart';
import 'package:calcubon/blocs/chatAI/chat_ai_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatAiBloc extends Bloc<ChatAiEvent, ChatAiState> {
  final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://api.openai.com/v1',
    headers: {
      'Authorization':
          'Bearer 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',
      'Content-Type': 'application/json',
    },
  ));

  ChatAiBloc() : super(InitialChatAiState());

  @override
  Stream<ChatAiState> mapEventToState(ChatAiEvent event) async* {
    if (event is AskGPTEvent) {
      yield ChatAiLoading();
      try {
        final response = await dio.post(
          'https://api.openai.com/v1/chat/completions',
          data: {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "system",
                "content":
                    "kamu adalah seorang asisten dokter yang berpengalaman dalam bidang kesehatan gigi. Jika kamu diberi pertanyaan diluar bidang kamu, jawab saja saya tidak tau.",
              },
              {
                "role": "user",
                "content": event.pertanyaan,
              },
            ],
            "temperature": 1,
            "max_tokens": 256,
            "top_p": 1,
            "frequency_penalty": 0,
            "presence_penalty": 0,
          },
        );

        final responseData = response.data;

        if (responseData.containsKey('choices') &&
            responseData['choices'].isNotEmpty) {
          final answerText = responseData['choices'][0]['message']['content'];
          yield ChatAiSuccess(answerText);
        } else {
          yield ChatAiError('No answer available.');
        }
      } catch (e) {
        yield ChatAiError('An error occurred.');
      }
    }
  }
}
