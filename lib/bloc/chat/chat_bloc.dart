import 'package:chat_app/models/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is OnEnviarMensaje) {
      List<ChatModel> chat = (state.chat != null)
          ? state.chat.map((e) => e.copyWith(nuevo: false)).toList()
          : [];
      yield state.copyWith(chat: chat, isWorking: false);
      yield* _onEnviarMensaje(event);
    }
    if (event is OnObtenerMensajes) {
      yield* _onObtenerMensaje(event);
    }
  }

  Stream<ChatState> _onEnviarMensaje(OnEnviarMensaje event) async* {
    yield state.copyWith(
        enviarMensaje: true, isWorking: true, obtieneChats: false);
    List<ChatModel> chat = state?.chat ?? [];
    final nuevoMensaje =
        new ChatModel(uid: '1232', mensaje: event.mensaje, nuevo: true);
    chat.insert(0, nuevoMensaje);
    yield state.copyWith(
      chat: chat,
      isWorking: false,
    );
  }

  Stream<ChatState> _onObtenerMensaje(OnObtenerMensajes event) async* {
    //TODO
    yield state.copyWith(
        isWorking: true, enviarMensaje: false, obtieneChats: true);
    List<ChatModel> chat = (state.chat != null)
        ? state.chat.map((e) => e.copyWith(nuevo: false))
        : [];
    yield state.copyWith(chat: chat, isWorking: false);
  }
}
