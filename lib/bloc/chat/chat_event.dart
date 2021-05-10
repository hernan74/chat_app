part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class OnEnviarMensaje extends ChatEvent {
  final String mensaje;

  OnEnviarMensaje(this.mensaje);
}

class OnRecibirMensaje extends ChatEvent {
  final ChatModel mensaje;

  OnRecibirMensaje(this.mensaje);
}

class OnObtenerMensajes extends ChatEvent {}

class OnEstablecerReceptorEvent extends ChatEvent {
  final Usuario propietario;
  final Usuario receptor;

  OnEstablecerReceptorEvent(this.propietario, this.receptor);
}

class OnInitChatEvent extends ChatEvent {}
