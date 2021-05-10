part of 'server_status_bloc.dart';

@immutable
class ServerStatusState {
  final ServerStatus serverStatus;

  ServerStatusState({this.serverStatus = ServerStatus.Offline});

  ServerStatusState copyWith({ServerStatus serverStatus}) =>
      ServerStatusState(serverStatus: serverStatus ?? this.serverStatus);
}

class OnInitServerStatusState extends ServerStatusState {}

class OnStatusChange extends ServerStatusState {
  OnStatusChange({ServerStatusState state})
      : super(serverStatus: state.serverStatus);
}
