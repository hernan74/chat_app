import 'package:chat_app/models/mensajes_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';

part 'chat_state.dart';
part 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState());

  final SocketService _service = SocketService();
  final ChatService _mensajesResponse = new ChatService();
  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is OnEnviarMensaje) {
      List<ChatModel> chat = (state.chat != null)
          ? state.chat.map((e) => e.copyWith(nuevo: false)).toList()
          : [];
      yield state.copyWith(chat: chat, isWorking: false);
      yield* _onEnviarMensaje(event);
    } else if (event is OnInitChatEvent) {
      yield OnInitChatState();
    } else if (event is OnObtenerMensajes) {
      yield* _onObtenerMensaje(event);
    } else if (event is OnEstablecerReceptorEvent) {
      yield* _onEstablecerReceptor(event);
    } else if (event is OnRecibirMensaje) {
      List<ChatModel> chat = (state.chat != null)
          ? state.chat.map((e) => e.copyWith(nuevo: false)).toList()
          : [];
      chat.insert(0, event.mensaje);
      yield state.copyWith(
        chat: chat,
        isWorking: false,
      );
    }
  }

  Stream<ChatState> _onEnviarMensaje(OnEnviarMensaje event) async* {
    yield state.copyWith(
        enviarMensaje: true, isWorking: true, obtieneChats: false);
    List<ChatModel> chat = (state.chat != null)
        ? state.chat.map((e) => e.copyWith(nuevo: false)).toList()
        : [];
    final nuevoMensaje = new ChatModel(
        uid: state.propietario.uid, mensaje: event.mensaje, nuevo: true);

    chat.insert(0, nuevoMensaje);
    this._service.emit('mensaje-personal', {
      'de': state.propietario.uid,
      'para': state.receptor.uid,
      'mensaje': event.mensaje
    });
    yield state.copyWith(
      chat: chat,
      isWorking: false,
    );
  }

  Stream<ChatState> _onObtenerMensaje(OnObtenerMensajes event) async* {
    yield state.copyWith(
        isWorking: true, enviarMensaje: false, obtieneChats: true);
    List<Mensaje> chat = await _mensajesResponse.getChats(state.receptor.uid);

    yield state.copyWith(
        chat: chat
            .map((e) =>
                new ChatModel(mensaje: e.mensaje, uid: e.de, nuevo: false))
            .toList(),
        isWorking: false,
        obtieneChats: false);
  }

  Stream<ChatState> _onEstablecerReceptor(
      OnEstablecerReceptorEvent event) async* {
    yield OnEstablecerReceptorState(
        state: state.copyWith(
            propietario: event.propietario, receptor: event.receptor));
  }
}
