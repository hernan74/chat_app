part of 'server_status_bloc.dart';

@immutable
abstract class ServerStatusEvent {}

class OnServerStatusChangeEvent extends ServerStatusEvent {
  final ServerStatus serverStatus;

  OnServerStatusChangeEvent(this.serverStatus);
}
