import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:chat_app/global/environment.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService {
  static final SocketService _instancia = new SocketService.internal();

  ServerStatus get serverStatus => this._serverStatus;
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  factory SocketService() {
    return _instancia;
  }

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect(String token) async {
    // Dart client
    if (this._socket != null) {
      if (this._socket.disconnected) {
        this._socket.connect();
      }
      return;
    } else {
      print('Se crea la instancia');
    }
    _socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });
  }

  void disconect() {
    this._socket?.disconnect();
  }

  SocketService.internal();
}
