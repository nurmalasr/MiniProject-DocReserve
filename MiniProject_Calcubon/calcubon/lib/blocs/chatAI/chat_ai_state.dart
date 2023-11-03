import 'package:equatable/equatable.dart';

abstract class ChatAiState extends Equatable {
  const ChatAiState();

  @override
  List<Object> get props => [];
}

class InitialChatAiState extends ChatAiState {}

class ChatAiLoading extends ChatAiState {}

class ChatAiSuccess extends ChatAiState {
  final String jawaban;

  ChatAiSuccess(this.jawaban);

  @override
  List<Object> get props => [jawaban];
}

class ChatAiError extends ChatAiState {
  final String error;

  ChatAiError(this.error);

  @override
  List<Object> get props => [error];
}
