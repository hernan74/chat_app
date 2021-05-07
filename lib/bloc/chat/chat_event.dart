part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class OnEnviarMensaje extends ChatEvent {
  final String mensaje;

  OnEnviarMensaje(this.mensaje);
}

class OnObtenerMensajes extends ChatEvent {}
