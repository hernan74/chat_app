class ChatModel {
  final String uid;
  final String mensaje;
  final bool nuevo;

  ChatModel({
    this.uid,
    this.mensaje,
    this.nuevo,
  });

  ChatModel copyWith({String uid, String mensaje, bool nuevo}) => ChatModel(
      uid: uid ?? this.uid,
      mensaje: mensaje ?? this.mensaje,
      nuevo: nuevo ?? this.nuevo);
}
