import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/services/secure_storage.dart';

import 'package:http/http.dart' as http;

class ChatService {
  Future<List<Mensaje>> getChats(String usuarioUID) async {
    try {
      final url = Uri.parse('${Environment.apiUrl}mensajes/$usuarioUID');

      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await SecureStorage().storage.read(key: 'token')
      });
      final mensajesResponse = mensajesResponseFromJson(resp.body);
      return mensajesResponse.mensajes;
    } catch (error) {
      return null;
    }
  }
}
