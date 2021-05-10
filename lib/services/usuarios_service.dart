import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app/global/environment.dart';

class UsuariosService {
  Future<UsuariosResponse> getUsuarios() async {
    try {
      final url = Uri.parse('${Environment.apiUrl}usuarios');

      final resp = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'x-token': await SecureStorage().storage.read(key: 'token')
      });
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse;
    } catch (error) {
      return null;
    }
  }
}
