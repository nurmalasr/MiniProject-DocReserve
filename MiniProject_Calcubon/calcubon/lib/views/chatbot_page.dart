import 'package:calcubon/blocs/chatAI/chat_ai_bloc.dart';
import 'package:calcubon/blocs/chatAI/chat_ai_event.dart';
import 'package:calcubon/blocs/chatAI/chat_ai_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot'),
      ),
      body: ChatBotBody(),
    );
  }
}

class ChatBotBody extends StatefulWidget {
  @override
  _ChatBotBodyState createState() => _ChatBotBodyState();
}

class _ChatBotBodyState extends State<ChatBotBody> {
  TextEditingController pertanyaanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatAiBloc(),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatAiBloc, ChatAiState>(
              builder: (context, state) {
                if (state is ChatAiSuccess) {
                  return Center(
                    child: Text(state.jawaban),
                  );
                } else if (state is ChatAiLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ChatAiError) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Pertanyaan Anda',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: pertanyaanController,
                        decoration: InputDecoration(
                          labelText: 'Masukkan pertanyaan',
                          contentPadding: EdgeInsets.all(12.0),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          final pertanyaan = pertanyaanController.text;
                          context
                              .read<ChatAiBloc>()
                              .add(AskGPTEvent(pertanyaan));
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(16.0)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
