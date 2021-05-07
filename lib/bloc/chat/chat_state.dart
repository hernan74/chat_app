part of 'chat_bloc.dart';

@immutable
class ChatState {
  final List<ChatModel> chat;
  final bool obtieneChats;
  final bool enviarMensaje;
  final bool isWorking;

  ChatState({
    this.chat,
    this.enviarMensaje,
    this.isWorking,
    this.obtieneChats,
  });

  ChatState copyWith(
          {List<ChatModel> chat,
          bool enviarMensaje,
          bool isWorking,
          bool obtieneChats}) =>
      ChatState(
          chat: chat ?? this.chat,
          enviarMensaje: enviarMensaje ?? this.enviarMensaje,
          isWorking: isWorking ?? this.isWorking,
          obtieneChats: obtieneChats ?? this.obtieneChats);

  ChatState initState() => ChatState();
}
