import 'package:equatable/equatable.dart';

abstract class ChatAiEvent extends Equatable {
  const ChatAiEvent();

  @override
  List<Object> get props => [];
}

class AskGPTEvent extends ChatAiEvent {
  final String pertanyaan;

  AskGPTEvent(this.pertanyaan);

  @override
  List<Object> get props => [pertanyaan];
}
