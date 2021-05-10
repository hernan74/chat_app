import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:meta/meta.dart';

part 'server_status_event.dart';
part 'server_status_state.dart';

class ServerStatusBloc extends Bloc<ServerStatusEvent, ServerStatusState> {
  ServerStatusBloc() : super(OnInitServerStatusState());
  final _socketServer = new SocketService();
  @override
  Stream<ServerStatusState> mapEventToState(
    ServerStatusEvent event,
  ) async* {
    if (event is OnServerStatusChangeEvent) {
      yield* _onServerStatusChange(event);
    }
    this._socketServer.socket.on('connect', (_) {
      print('Se conecto al servidor');
      this.add(OnServerStatusChangeEvent(ServerStatus.Online));
    });
    this._socketServer.socket.on('disconnect', (_) {
      print('Se desconecto del servidor');
      this.add(OnServerStatusChangeEvent(ServerStatus.Offline));
    });
  }

  Stream<ServerStatusState> _onServerStatusChange(
      OnServerStatusChangeEvent event) async* {
    yield OnStatusChange(
        state: state.copyWith(serverStatus: event.serverStatus));
  }
}
