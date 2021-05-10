part of 'chat_bloc.dart';

@immutable
class ChatState {
  final List<ChatModel> chat;
  final Usuario propietario;
  final Usuario receptor;
  final bool obtieneChats;
  final bool enviarMensaje;
  final bool isWorking;

  ChatState({
    this.propietario,
    this.receptor,
    this.chat,
    this.enviarMensaje = false,
    this.isWorking = false,
    this.obtieneChats = false,
  });

  ChatState copyWith(
          {Usuario propietario,
          Usuario receptor,
          List<ChatModel> chat,
          bool enviarMensaje,
          bool isWorking,
          bool obtieneChats}) =>
      ChatState(
          receptor: receptor ?? this.receptor,
          propietario: propietario ?? this.propietario,
          chat: chat ?? this.chat,
          enviarMensaje: enviarMensaje ?? this.enviarMensaje,
          isWorking: isWorking ?? this.isWorking,
          obtieneChats: obtieneChats ?? this.obtieneChats);

  ChatState initState() => ChatState();
}

class OnEstablecerReceptorState extends ChatState {
  OnEstablecerReceptorState({ChatState state})
      : super(
            propietario: state.propietario,
            receptor: state.receptor,
            chat: state.chat,
            enviarMensaje: state.enviarMensaje,
            isWorking: state.isWorking,
            obtieneChats: state.obtieneChats);
}

class OnInitChatState extends ChatState {}
